#!/usr/bin/env bash 
echo "Downloading tmux plugin manager"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Creating symlinks"
#bash_profile OSX
if [[ "$OSTYPE" == "darwin"* ]]; then
  ln -s ~/dotfiles/shells/zshrc ~/.zshrc
  ln -s ~/dotfiles/shells/bashrc ~/.bash_profile;
  #profile, if doesnt exist
  touch ~/.profile
  ###########
  # chunkwm #
  ###########

  # chmod +x chunkwmrc
  # chmod +x skhdrc
  # ln -s ~/dotfiles/chunkwm/chunkwmrc ~/.chunkwmrc
  # ln -s ~/dotfiles/chunkwm_plugins ~/.chunkwm_plugins
  # ln -s ~/dotfiles/chunkwm/skhdrc ~/.skhdrc
  # if [ -d ~/.config/kitty ]; then
  #   mv ~/.config/kitty/kitty.conf ~/.config/kitty/oldkitty.conf
  #   ln -s ~/dotfiles/kitty.conf ~/.config/kitty/kitty.conf
  # else
  #   echo "can't find a .config dir for kitty terminal, make sure the program is installed correctly"
  # fi
  
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
  ln -s ~/dotfiles/shells/zshrc ~/.zshrc
  ln -s ~/dotfiles/shells/bash_profile ~/.bashrc
  ln -s ~/dotfiles/shells/inputrc ~/.inputrc
  echo "skipping links to bash_profile and chunkWM"
fi

#tmux
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
# dircolors
ln -s ~/dotfiles/dircolors ~/.dircolors
#vim
ln -s ~/dotfiles/vim/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/vim/ideavimrc ~/.ideavimrc
#if [ ! -d ~/.vim/colors ]; then mkdir ~/.vim; mkdir ~/.vim/colors; fi
#ln -s ~/dotfiles/vim/solarized.vim ~/.vim/colors/solarized.vim
#psql
ln -s ~/dotfiles/psqlrc ~/.psqlrc
