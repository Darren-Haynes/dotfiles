"""
Create config file symlinks from my dotfiles.
"""

from os import makedirs, readlink, rename, symlink, unlink
from os.path import expanduser, isfile, islink, join, split


def create_dirs(dirs):
    """
    Create nesessary directory that some dofiles will exist in
    """
    for each_dir in dirs:
        try:
            makedirs(each_dir)
            print("{} directory created".format(each_dir))
        except FileExistsError:
            message = "Skip creating {} directory, it already exits "
            print(message.format(each_dir))

    return True


def create_syms(dotfiles):
    """TODO: Docstring for create_syms.
    :returns: TODO

    """
    for files in dotfiles:
        src = files[0]
        dest = files[1]

        if islink(dest):
            if readlink(dest) == src:
                print("{} already symlinks to {}".format(dest, readlink(dest)))
                continue
            else:
                print("Incorrect symlink, deleting and recreating")
                print("{} now points to {}".format(dest, src))
                unlink(dest)
                symlink(src, dest)
                continue

        elif isfile(dest):
            path, file = split(dest)
            backup = file + ".b4dots"
            backup_file = join(path, backup)
            rename(dest, backup_file)
            symlink(src, dest)
            message1 = "Original file {} backed up to {}"
            message2 = "Symlink created {} --> {} created"
            print(message1.format(dest, backup_file))
            print(message2.format(dest, src))

        else:
            symlink(src, dest)
            print("Symlink {} --> {}".format(dest, src))

    return True


def main():
    """TODO: Docstring for main.
    :returns: TODO

    """

    home = expanduser("~")
    dots_dir = join(home, "dotfiles")

    # Vim and neovim
    my_vimrc = join(dots_dir, "vim/vimrc")
    orig_vimrc = join(home, ".vimrc")
    my_nvim_init = join(dots_dir, "nvim/init.vim")
    orig_nvim_init = join(home, ".config/nvim/init.vim")

    # Aliases
    my_aliases = join(dots_dir, "aliases")
    orig_aliases = join(home, ".aliases")

    # X
    my_xresources = join(dots_dir, "X/Xresources")
    orig_xresources = join(home, ".Xresources")

    # Ranger
    my_ranger_bookmarks = join(dots_dir, "ranger/bookmarks")
    orig_ranger_bookmarks = join(home, ".config/ranger/bookmarks")
    my_ranger_scope = join(dots_dir, "ranger/scope.sh")
    orig_ranger_scope = join(home, ".config/ranger/scope.sh")
    my_ranger_conf = join(dots_dir, "ranger/rc.conf")
    orig_ranger_conf = join(home, ".config/ranger/rc.conf")

    # Python
    my_ipython_config = join(dots_dir, "Python/ipython_config.py")
    orig_ipython_config = join(home,
                               ".ipython/profile_default/ipython_config.py")
    my_pdbrc_config = join(dots_dir, "Python/pdbrc")
    orig_pdbrc_config = join(home, ".pdbrc")
    my_pylintrc_config = join(dots_dir, "Python/pylintrc")
    orig_pylintrc_config = join(home, ".pylintrc")

    dotfiles = [
        (my_vimrc, orig_vimrc),
        (my_aliases, orig_aliases),
        (my_xresources, orig_xresources),
        (my_ipython_config, orig_ipython_config),
        (my_pdbrc_config, orig_pdbrc_config),
        (my_pylintrc_config, orig_pylintrc_config),
        (my_nvim_init, orig_nvim_init),
        (my_ranger_bookmarks, orig_ranger_bookmarks),
        (my_ranger_scope, orig_ranger_scope),
        (my_ranger_conf, orig_ranger_conf),

    ]

    # Some dirs that need creating first
    ipython_dir = join(home, ".ipython/profile_default")
    nvim_dir = join(home, ".config/nvim")

    dirs_to_create = [
        ipython_dir,
        nvim_dir
    ]

    create_dirs(dirs_to_create)
    create_syms(dotfiles)
    print("Finished Creating Symlinks")


if __name__ == "__main__":
    main()
