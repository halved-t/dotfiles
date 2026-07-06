#!/bin/bash

installprogrs(){
echo "Installing programs..."
cd ~
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm && cd .. && rm -rf yay
yay -S --noconfirm zen-browser-bin visual-studio-code-bin ttf-google-sans-code-vf
echo "don't forget to exit"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
}

dotfileinstall(){
echo "Symlinking dotfiles..."
if [ -d "$HOME/.config/dotfiles/.git" ]; then
  echo "You already have the git repo, pulling instead."
  cd "$HOME/.config/dotfiles" && git pull
  cd ~
else
  git clone https://github.com/halved-t/dotfiles.git ~/.config/dotfiles
fi

[ -L ~/.config/waybar ] || ln -s ~/.config/dotfiles/dots/waybar ~/.config/waybar
[ -L ~/.config/alacritty ] || ln -s ~/.config/dotfiles/dots/alacritty ~/.config/alacritty
[ -L ~/.config/sway ] || ln -s ~/.config/dotfiles/dots/sway ~/.config/sway
[ -L ~/.config/swaylock ] || ln -s ~/.config/dotfiles/dots/swaylock ~/.config/swaylock
[ -L ~/.config/fastfetch ] || ln -s ~/.config/dotfiles/dots/fastfetch ~/.config/fastfetch
[ -L ~/.config/wofi ] || ln -s ~/.config/dotfiles/dots/wofi ~/.config/wofi
[ -L ~/.config/Code/User/settings.json ] || ln -s ~/.config/dotfiles/dots/vscode/settings.json ~/.config/Code/User/settings.json
}

read -p "do yay setup+omb? (y/n) " yn
case $yn in
  [Yy]*) installprogrs; dotfileinstall;;
  [Nn]*) dotfileinstall;;
  *) exit;;
esac
