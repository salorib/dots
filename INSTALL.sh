#!/bin/bash

Packages="xdg-user-dirs,picom,zsh,neovim,rofi,polybar,thunar,ranger,python-pywal,feh,flameshot,i3lock,neofetch,bashtop"
oldIFS=$IFS
IFS=,
HOME=/home/salorib

#AUR package manager
sudo pacman -S base-devel git
mkdir aur
cd aur
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

#install fonts
sudo pacman -S ttf-font-awesome ttf-jetbrains-mono 
yay -S nerd-fonts-jetbrains-mono 

#Install zsh and dependencies
sudo pacman -S zsh
#Change default shell to zsh:
chsh -s $(which zsh)
#Install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#Install powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
#Copy zsh config files to home directory
cp $HOME/.config/zsh/.zshrc $HOME
cp $HOME/.config/zsh/.p10k.zsh $HOME


checkpckg(){
echo "Checking if $1 is installed:"
if pacman -Q $1 > /dev/null; then 
	echo $1 is installed, skiping;
else
	read -p "$1 is not installed, install $1? (y/n) " var
	if [[ $var == 'y' || $var == 'Y' || $var == 'yes' || $var == 'Yes' || $var == 'YES' ]]; then 
		sudo pacman -S $1
	fi
fi
echo '';
}

for Pack in $Packages;
do
	checkpckg $Pack
done

#Update XDG directories
if pacman -Q xdg-user-dirs > /dev/null; then
	xdg-user-dirs-update
fi


IFS=$oldIFS

