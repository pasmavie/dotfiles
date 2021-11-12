#!/usr/bin/env bash 

# config dir
if [ ! -d $HOME/.config ]; then mkdir $HOME/.config; fi

# tmux
echo "Downloading tmux plugin manager"
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

ln -s $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
# dircolors
ln -s $HOME/dotfiles/dircolors $HOME/.dircolors

# nvim
# if [ ! -d $HOME/.config/nvim ]; then mkdir $HOME/.config/nvim; fi
# ln -s $HOME/dotfiles/vim/init.vim $HOME/.config/nvim/init.vim
# ln -s $HOME/dotfiles/vim/vimrc $HOME/.vimrc
# spacevim
if [ ! -d $HOME/.SpaceVim.d ]; then echo 'SpaceVim config folder not found. Make sure SpaceVim is installed'; fi
if [ -f $HOME/.SpaceVim.d/init.toml ]; then echo 'SpaceVim - Replacing the existing config file with a symlink to dotfiles/spacevim/init.toml'; mv $HOME/.SpaceVim.d/init.toml $HOME/.SpaceVim.d/old_init.toml;fi
ln -s $HOME/dotfiles/spacevim/init.toml $HOME/.SpaceVim.d/init.toml

# jetbrains
ln -s $HOME/dotfiles/vim/ideavimrc $HOME/.ideavimrc

# psql
ln -s $HOME/dotfiles/psqlrc $HOME/.psqlrc

# python
ln -s $HOME/dotfiles/python/mypy.ini $HOME/.mypy.ini

# zsh
ln -s $HOME/dotfiles/shells/zshrc $HOME/.zshrc

echo "Creating symlinks"
# bash_profile OSX
if [[ "$OSTYPE" == "darwin"* ]]; then
  ln -s $HOME/dotfiles/shells/bashrc $HOME/.bash_profile
  # profile, if doesnt exist
  touch $HOME/.profile
  ###########
  # chunkwm #
  ###########
  # chmod +x chunkwmrc
  # chmod +x skhdrc
  # ln -s $HOME/dotfiles/chunkwm/chunkwmrc $HOME/.chunkwmrc
  # ln -s $HOME/dotfiles/chunkwm_plugins $HOME/.chunkwm_plugins
  # ln -s $HOME/dotfiles/chunkwm/skhdrc $HOME/.skhdrc
  # if [ -d $HOME/.config/kitty ]; then
  #   mv $HOME/.config/kitty/kitty.conf $HOME/.config/kitty/oldkitty.conf
  #   ln -s $HOME/dotfiles/kitty.conf $HOME/.config/kitty/kitty.conf
  # else
  #   echo "can't find a .config dir for kitty terminal, make sure the program is installed correctly"
  # fi
  
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
  ln -s $HOME/dotfiles/shells/bashrc $HOME/.bashrc
  ln -s $HOME/dotfiles/shells/inputrc $HOME/.inputrc
fi

# if [ ! -d $HOME/.config/matplotlib ]; then mkdir $HOME/.config/matplotlib; fi
# ln -s $HOME/dotfiles/matplotlibrc $HOME/.config/matplotlib/matplotlibrc
