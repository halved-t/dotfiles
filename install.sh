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

ln -sf ~/.config/dotfiles/dots/quickshell ~/.config/quickshell
ln -sf ~/.config/dotfiles/dots/alacritty ~/.config/alacritty
ln -sf ~/.config/dotfiles/dots/sway ~/.config/sway
ln -sf ~/.config/dotfiles/dots/fastfetch ~/.config/fastfetch
ln -sf ~/.config/dotfiles/dots/wofi ~/.config/wofi
ln -sf ~/.config/dotfiles/dots/vscode/settings.json ~/.config/Code/User/settings.json
}

read -p "do yay setup+omb? (y/n) " yn
case $yn in
  [Yy]*) installprogrs; dotfileinstall;;
  [Nn]*) dotfileinstall;;
  *) exit;;
esac
