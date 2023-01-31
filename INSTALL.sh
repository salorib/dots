#Vars
$HOME = /home/salorib

#XDG directories
sudo pacman -S xdg-user-dirs
xdg-user-dirs-update

#AUR package manager
sudo pacman -S base-devel git
mkdir aur
cd aur
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

#Install compositor
sudo pacman -S picom

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

#install fonts
sudo pacman -S ttf-font-awesome ttf-jetbrains-mono 
yay -S nerd-fonts-jetbrains-mono 

#Install editor: neovim 
sudo pacman -S neovim

#Install switcher: rofi
sudo pacman -S rofi

#Install status bar: Polybar
sudo pacman -S polybar

#Install filemanagers: ranger and thunar
sudo pacman -S thunar ranger 

#Install color palette generator: pywal
sudo pacman -S python-pywal

#Install image viewer: feh 
sudo pacman -S feh

#Install tools: screenshots, lock screen, etc
sudo pacman -S flameshot i3lock neofetch bashtop


