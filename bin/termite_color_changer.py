import os

HOME = os.path.expanduser("~")
DIR = os.path.join(HOME, "dotfiles/termite")
CONFIG = os.path.join(DIR, "config")


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

    with open('/home/darren/dotfiles/termite/temp', 'w') as config_file:
        config_file.write(''.join(config_no_colors))

def choose_theme(themes):
    """User selects colorscheme."""
    print(' ')

    invalid_selection = True
    while invalid_selection:
        for theme in themes:
            print("{} - {}").format(theme[0], theme_name(theme))

        selection = input("\nChoose theme number: ")

        if isinstance(selection, int) \
            and selection > 0 and selection < len(themes) + 1:

            for theme in themes:
                if theme[0] == selection:
                    print("You selected the {} theme").format(theme_name(theme))
            break

        print("\nChoose a valid theme number\nTry again\n")

def main():
    """Get indexed list of color theme files."""
    files = [os.path.join(DIR, f) for f in os.listdir(DIR)
             if os.path.isfile(os.path.join(DIR, f))]
    tc_files = [f for f in files if f.endswith('.tc')]
    i = 0
    themes = []
    for f in tc_files:
        i += 1
        themes.append((i, f))

    choose_theme(themes)





if __name__ == '__main__':
    main()


