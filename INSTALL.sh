#!/bin/bash

#Packages to install
Packages="git,xdg-user-dirs,picom,zsh,neovim,rofi,polybar,thunar,ranger,python-pywal,feh,flameshot,i3lock,neofetch,bashtop"
#Fonts to install
Fonts="ttf-font-awesome,ttf-jetbrains-mono,ttf-jetbrains-mono-nerd"
oldIFS=$IFS
IFS=,
HOME=/home/salorib

#Check if packages are already installed
checkpckg(){
echo "Checking if $1 is installed:"
if pacman -Q $1 > /dev/null 2>&1 ; then 
    echo $1 is installed, skipping;
else
    read -p "$1 is not installed, install $1? (y/n) " var
    if [[ $var == 'y' || $var == 'Y' || $var == 'yes' || $var == 'Yes' || $var == 'YES' ]]; then 
        sudo pacman -S $1
    fi
fi
echo '';
}


#AUR package manager
echo "Checking if yay is installed:"
if pacman -Q yay > /dev/null 2>&1 ; then 
    echo yay is installed, skipping;
    echo ""
else
    sudo pacman -S base-devel
    mkdir aur
    cd aur
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
fi

#Install fonts
for Font in $Fonts;
do
    checkpckg $Font
done

#Install all Packages
for Pack in $Packages;
do
    checkpckg $Pack
done

read -p "Install Oh My Zsh! ? (y/n) " var
if [[ $var == 'y' || $var == 'Y' || $var == 'yes' || $var == 'Yes' || $var == 'YES' ]]; then 
    if ! pacman -Q zsh > /dev/null ; then
        echo "zsh is not installed, install zsh before install Oh My Zsh!"
        #Install zsh and dependencies
        sudo pacman -S zsh
        #Change default shell to zsh:
        chsh -s $(which zsh)
    fi
    #Install oh my zsh
    echo "Installing oh my zsh! ..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    #Install powerlevel10k theme
    echo Installing powerlevel10k theme ...
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    #Copy zsh config files to home directory
    echo Copying configuration ...
    cp $HOME/.config/zsh/.zshrc $HOME
    cp $HOME/.config/zsh/.p10k.zsh $HOME
else
    echo ""
fi

#Update XDG directories
if pacman -Q xdg-user-dirs > /dev/null 2>&1 ; then
    xdg-user-dirs-update
fi

read -p "Install vim-plug? (y/n) " var
if [[ $var == 'y' || $var == 'Y' || $var == 'yes' || $var == 'Yes' || $var == 'YES' ]]; then 
    echo "Installing vim-plug ..."
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
else
    echo ""
fi

IFS=$oldIFS

