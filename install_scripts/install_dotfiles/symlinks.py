"""
Create config file symlinks from my dotfiles.
"""

from os import makedirs
from os import readlink
from os import rename
from os import symlink
from os import unlink
from os.path import expanduser
from os.path import join
from os.path import isfile
from os.path import islink
from os.path import split

def create_dirs(dirs):
    """
    Create nesessary directory that some dofiles will exist in
    """
    for dir in dirs:
        try:
            makedirs(dir)
            print("{} directory created".format(dir))
        except FileExistsError:
            print("Skip creating {} directory, it already exits ".format(dir))
            pass

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
            message = """Original file {} backed up to {}
                and symlink {} --> {} created"""
            print(message.format(dest, backup_file, dest, src))

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
    config = join(home, ".config")

    # Vim and neovim
    my_vimrc = join(dots_dir, "vim/vimrc")
    orig_vimrc = join(home, ".vimrc")
    my_nvim_init = join(dots_dir, "nvim/init.vim")
    orig_nvim_init = join(home, ".config/nvim/init.vim")

    # Zsh and aliases
    my_zshrc = join(dots_dir, "zsh/zshrc")
    orig_zshrc = join(home, ".zshrc")
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
    orig_ipython_config = join(home, ".ipython/profile_default/ipython_config.py")
    my_pdbrc_config = join(dots_dir, "Python/pdbrc")
    orig_pdbrc_config = join(home, ".pdbrc")


    dotfiles = [
        (my_vimrc, orig_vimrc),
        (my_zshrc, orig_zshrc),
        (my_aliases, orig_aliases),
        (my_xresources, orig_xresources),
        (my_ipython_config, orig_ipython_config),
        (my_pdbrc_config, orig_pdbrc_config),
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

if __name__ == "__main__":
    main()
