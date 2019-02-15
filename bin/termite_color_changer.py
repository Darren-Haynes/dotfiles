"""
TERMITE COLORSCHEME CHANGER

Provides a menu of colorschemes for user to choose from and then
changes the scheme on the fly.
"""

import os

HOME = os.path.expanduser("~")
BASE = os.path.join(HOME, ".config/termite")
THEMES_DIR = os.path.join(HOME, ".config/termite/themes")
CONFIG = os.path.join(BASE, "config")


def theme_name(theme_path):
    fname = os.path.split(theme_path[1])[1]
    name = fname.split('.')[0].title().replace('_', ' ')
    return name


def change_theme(theme):
    """Change theme in termite config file."""
    with open(CONFIG, 'r') as config_file:
        config = config_file.readlines()
        config_no_colors = []
        for line in config:
            if line.startswith('[colors]'):
                break
            config_no_colors.append(line)

    with open(theme, 'r') as theme_file:
        color_theme = theme_file.readlines()

    with open(CONFIG, 'w') as config_file:
        config_file.write(''.join(config_no_colors) + ''.join(color_theme))


def choose_theme(themes):
    """User selects colorscheme."""
    print(' ')

    while True:
        for theme in themes:
            print("{} - {}".format(theme[0], theme_name(theme)))

        selection = input("\nChoose theme number: ")

        if selection.isdigit() \
                and int(selection) > 0 and int(selection) < len(themes) + 1:

            for theme in themes:
                if theme[0] == int(selection):
                    print("You selected the {} theme".format(
                        theme_name(theme)))
                    color_theme = theme[1]

            break

        print("\nChoose a valid theme number\nTry again\n")

    change_theme(color_theme)


def main():
    """Get indexed list of color theme files."""
    files = [os.path.join(THEMES_DIR, f) for f in os.listdir(THEMES_DIR)
             if os.path.isfile(os.path.join(THEMES_DIR, f))]
    i = 0
    themes = []
    for f in files:
        i += 1
        themes.append((i, f))

    choose_theme(themes)


if __name__ == '__main__':
    main()
