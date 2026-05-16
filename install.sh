#!/bin/bash

printtext(){
echo "    ____        __  _____ __        ____           __        ____         "
echo "   / __ \____  / /_/ __(_) /__     /  _/___  _____/ /_____ _/ / /__  _____"
echo "  / / / / __ \/ __/ /_/ / / _ \    / // __ \/ ___/ __/ __ \`/ / / _ \/ ___/"
echo " / /_/ / /_/ / /_/ __/ / /  __/  _/ // / / (__  ) /_/ /_/ / / /  __/ /    "
echo "/_____/\____/\__/_/ /_/_/\___/  /___/_/ /_/____/\__/\__,_/_/_/\___/_/     "
echo
echo
echo
}

installprogrs(){
echo "Installing programs..."
cd ~
sudo pacman -Syu hyprland hyprpaper hyprlock alacritty quickshell clang base-devel ninja cmake git qemu-full dolphin mako pipewire wireplumber pipewire-alsa pipewire-pulse pavucontrol xdg-desktop-portal-hyprland hyprpolkitagent qt5-wayland qt6-wayland noto-fonts noto-fonts-emoji noto-fonts-extra noto-fonts-cjk nerd-fonts woff2-font-awesome xorg-xwayland fastfetch wofi hyprpicker cliphist wl-clip-persist greetd greetd-tuigreet ripgrep fzf zoxide dialog wget btop tmux screen qt6 nasm openssh

git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm && cd .. && rm -rf yay
yay -S --noconfirm zen-browser-bin spotify visual-studio-code-bin vesktop ttf-google-sans-code-vf
#yay -S x86_64-elf-gcc
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" -- --unattended

sudo systemctl enable greetd
sudo sed -i 's/^command = .*/command = "tuigreet --cmd start-hyprland"/' /etc/greetd/config.toml
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
ln -sf ~/.config/dotfiles/dots/hypr ~/.config/hypr
ln -sf ~/.config/dotfiles/dots/fastfetch ~/.config/fastfetch
ln -sf ~/.config/dotfiles/dots/wofi ~/.config/wofi

sed -i 's/OSH_THEME="font"/OSH_THEME="robbyrussell"/' ~/.bashrc

cat << 'EOF' >> ~/.bashrc

unset CDPATH
eval "$(zoxide init bash)"
alias cd=z
EOF

echo "Installation is finished."
echo "You should probably restart your system now."
}

printtext
read -p "Do you want to install the applications? (y/n) " yn
case $yn in
  [Yy]*) installprogrs; dotfileinstall;;
  [Nn]*) dotfileinstall;;
  *) exit;;
esac
