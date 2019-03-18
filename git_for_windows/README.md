# Git for Windows

## Start ssh-agent on launch

1. Close Git for Windows
1. Copy .bashrc to %USERPROFILE%\.bashrc

In short, the .bashrc file would be found at C:\Users\USERNAME\.bashrc on a
stock Windows box.

The `.bash_profile` is mostly included here for reference. Git for Windows
usually creates this itself.

## Customize shell prompt

1. Close Git for Windows
1. Copy `.config/git/git-prompt.sh` to `%USERPROFILE%\.config\git\git-prompt.sh`

## References

- <https://github.com/deoren/config-files>

- <https://help.github.com/en/articles/working-with-ssh-key-passphrases#auto-launching-ssh-agent-on-git-for-windows>
- <https://alanbarber.com/2015/12/30/how-to-customize-the-git-for-windows-bash-shell-prompt/>
