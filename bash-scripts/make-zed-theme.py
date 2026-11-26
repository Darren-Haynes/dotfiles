#!/usr/bin/env python3
"""Generate the Zed theme that follows the desktop theme switcher.

    make-zed-theme.py <family> <accent> [output]

Writes ~/.config/zed/themes/desktop.json (default) containing two themes,
"Desktop Dark" and "Desktop Light", built from the checked-in family themes:

    bubblegum -> zed/themes/bubblegum/bubblegum+.json   ("Bubblegum", "Bubblegum Light")
    shhhed    -> zed/themes/shhhed/shhhed.json          ("shhhed", "shhhed light")

with the family's default accent swapped for <accent>. Zed settings point at
the two stable names, and Zed hot-reloads the file when it changes, so the
switcher can retheme a running Zed. Only accent-role colours are swapped
(borders, links, focus, the function colour for Bubblegum, ...); semantic ones
such as success/added or the terminal palette keep their own hues.
"""
import json
import os
import re
import subprocess
import sys

DOTFILES = os.path.dirname(os.path.dirname(os.path.realpath(__file__)))
PALETTE = os.path.join(DOTFILES, "bash-scripts", "theme-palette.sh")

# family -> source file, {variant: theme name inside the file}
FAMILIES = {
    "bubblegum": ("zed/themes/bubblegum/bubblegum+.json", {"dark": "Bubblegum", "light": "Bubblegum Light"}),
    "shhhed": ("zed/themes/shhhed/shhhed.json", {"dark": "shhhed", "light": "shhhed light"}),
}

# Key paths (regex, matched against the dotted path) that hold the accent colour.
ACCENT_PATHS = {
    "bubblegum": [
        r"border\.(focused|selected)", r"drop_target\.background", r"text\.accent", r"icon\.accent",
        r"(panel|pane)\.focused_border", r"editor\.document_highlight\.write_background",
        r"syntax\.function(\.method)?\.color",
    ],
    "shhhed": [
        r"text\.accent", r"icon\.accent", r"link_text(\.hover)?", r"drop_target\.background",
        r"border\.(focused|selected)", r"(panel|pane)\.focused_border",
        r"editor\.document_highlight\.(read|write|bracket)_background",
        r"search\.match_background", r"accents\.\d+",
        r"players\.\d+\.(cursor|background|selection)",
        r"syntax\.(link_text|link_uri|punctuation\.list_marker)\.color",
    ],
}
# shhhed only: the accent appears at index 5 of `players` and 6 of `accents`.
ONLY_INDEX = {"players": 5, "accents": 6}


def sh(expr):
    """Evaluate a function from theme-palette.sh."""
    out = subprocess.run(["bash", "-c", f'. "{PALETTE}"; {expr}'], capture_output=True, text=True)
    return out.stdout.strip()


def load_jsonc(path):
    text = open(path).read()
    text = re.sub(r"^\s*//.*$", "", text, flags=re.M)
    text = re.sub(r",(\s*[}\]])", r"\1", text)
    return json.loads(text)


def adjust(hexcol, amount):
    """Lighten (amount>0, towards white) or darken (amount<0, towards black)."""
    r, g, b = (int(hexcol[i:i + 2], 16) for i in (1, 3, 5))
    t = 255 if amount > 0 else 0
    a = abs(amount)
    return "#%02x%02x%02x" % tuple(round(c + (t - c) * a) for c in (r, g, b))


def walk(node, path, fn):
    if isinstance(node, dict):
        return {k: walk(v, path + [k], fn) for k, v in node.items()}
    if isinstance(node, list):
        return [walk(v, path + [str(i)], fn) for i, v in enumerate(node)]
    return fn(".".join(path), node)


def main():
    if len(sys.argv) < 3:
        sys.exit(__doc__)
    family, accent = sys.argv[1], sys.argv[2]
    out_path = sys.argv[3] if len(sys.argv) > 3 else os.path.expanduser("~/.config/zed/themes/desktop.json")
    if family not in FAMILIES:
        sys.exit(f"unknown family {family!r}")
    default = sh(f"theme_default_accent {family}")
    if accent not in sh(f"theme_accents {family}").split():
        sys.exit(f"unknown accent {accent!r} for {family}")

    src, names = FAMILIES[family]
    source = load_jsonc(os.path.join(DOTFILES, src))
    by_name = {t["name"]: t for t in source["themes"]}

    themes = []
    for variant, label in (("dark", "Desktop Dark"), ("light", "Desktop Light")):
        theme = json.loads(json.dumps(by_name[names[variant]]))
        orig = sh(f"accent_color {family} {variant} {default}").lower()
        new = sh(f"accent_color {family} {variant} {accent}").lower()
        theme["name"] = label
        if accent != default:
            hover = adjust(new, 0.18 if variant == "dark" else -0.22)
            patterns = [re.compile("^style\\.(" + p + ")$") for p in ACCENT_PATHS[family]]

            def swap(path, value, patterns=patterns, orig=orig, new=new, hover=hover):
                if not isinstance(value, str) or not any(p.match("style." + path) for p in patterns):
                    return value
                parts = path.split(".")
                if parts[0] in ONLY_INDEX and int(parts[1]) != ONLY_INDEX[parts[0]]:
                    return value
                if path == "link_text.hover":
                    return hover
                if value.lower().startswith(orig):
                    return new + value[7:]
                return value

            theme["style"] = walk(theme["style"], [], swap)
        themes.append(theme)

    doc = {
        "$schema": "https://zed.dev/schema/themes/v0.2.0.json",
        "name": "Desktop",
        "author": f"generated from {family} ({accent}) by make-zed-theme.py",
        "themes": themes,
    }
    os.makedirs(os.path.dirname(out_path), exist_ok=True)
    tmp = out_path + ".tmp"
    with open(tmp, "w") as f:
        json.dump(doc, f, indent=2)
        f.write("\n")
    os.replace(tmp, out_path)


if __name__ == "__main__":
    main()
