#!/bin/bash

srcdir=$(pwd)
laptop="FALSE"

echo "Are you on a laptop?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) laptop="TRUE"; break;;
        No ) break;;
    esac
done

sudo pacman -Syu

if [ laptop = "TRUE" ]; then
	sudo pacman -S --noconfirm acpi acpilight
fi

sudo pacman -S --noconfirm xorg-server xorg-xinit xterm xorg-xrandr xorg-xsetroot xorg-xprop picom ttf-font-awesome arc-gtk-theme alsa-utils pulseaudio-alsa pulsemixer openjdk8-src imagemagick xcb-util-xrm scrot feh lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings lxappearance ranger w3m udiskie dunst cmake xbindkeys

sudo pacman -S --noconfirm discord arandr evince gvfs gimp libreoffice htop cmatrix neofetch openssh firefox virtualbox virtualbox-guest-iso vim yarn npm

sudo systemctl enable lightdm.service

cp -r .config/ $HOME/
cp .xprofile $HOME/
cp .xbindkeysrc $HOME/
cp -r .scripts/ $HOME/
cd $HOME/.scripts/dwmstatus/ && make && make clean && cd $srcdir/
cp -r .vim/ $HOME/
cp .vimrc $HOME/
cp .bashrc $HOME/

sudo mkdir /etc/lightdm
sudo mkdir /media
mkdir $HOME/Pictures
mkdir $HOME/.bin
mkdir $HOME/.vim
mkdir $HOME/.vim/.swap
mkdir $HOME/.vim/.backup
mkdir $HOME/.vim/.undo

sudo ln -s /run/media/$USER /media/

sudo cp ./etc/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/
sudo cp ./usr/share/pixmaps/* /usr/share/pixmaps/
sudo cp ./Pictures/desktop_bg.jpg $HOME/Pictures/

if ! pacman -Qs silver-dmenu > /dev/null ; then
	cp -r silver-dmenu/ $HOME/.bin/
	cd $HOME/.bin/silver-dmenu/ && makepkg -sri --noconfirm && cd $srcdir/
fi

if ! pacman -Qs silver-surf > /dev/null ; then
	cp -r silver-surf/ $HOME/.bin/
	cd $HOME/.bin/silver-surf/ && makepkg -sri --noconfirm && cd $srcdir/
fi

if ! pacman -Qs silver-st > /dev/null ; then
	cp -r silver-st/ $HOME/.bin/
	cd $HOME/.bin/silver-st/ && makepkg -sri --noconfirm && cd $srcdir/
fi

if ! pacman -Qs silver-dwm > /dev/null ; then
	cp -r silver-dwm/ $HOME/.bin/
	cd $HOME/.bin/silver-dwm/ && makepkg -sri --noconfirm && cd $srcdir/
fi

################## Custom Scripts ##################################
git clone https://github.com/ZmanSilver/scripts.git
mv scripts/ $HOME/.scripts
####################################################################

################## Cursor theme ####################################
if ! pacman -Qs xcursor-openzone > /dev/null ; then
	cd $HOME/.bin/
	git clone https://aur-dev.archlinux.org/icon-slicer.git && cd icon-slicer/
	makepkg -sri --noconfirm
	cd $HOME/.bin/
	git clone https://aur.archlinux.org/xcursor-openzone.git && cd xcursor-openzone/
	makepkg -sri --noconfirm
fi
####################################################################

################## Google Play Music Desktop Player ################
if ! pacman -Qs gpmdp > /dev/null ; then
	cd $HOME/.bin/
	git clone https://aur.archlinux.org/gpmdp.git && cd gpmdp/
	makepkg -sri --noconfirm
fi
####################################################################

################## Lock screen program #############################
if ! pacman -Qs i3lock-color > /dev/null ; then
	cd $HOME/.bin/
	git clone https://aur.archlinux.org/i3lock-color.git && cd i3lock-color/
	makepkg -sri --noconfirm
fi
####################################################################

################## Command line visualizer #########################
if ! pacman -Qs cli-visualizer > /dev/null ; then
	cd $HOME/.bin/
	git clone https://aur.archlinux.org/cli-visualizer.git && cd cli-visualizer/
	makepkg -sri --noconfirm
fi
####################################################################

################## Vim plugin manager ####################
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
fi
####################################################################

################## Vim code completion plugin ######################
if [ -d ~/.vim/bundle/YouCompleteMe ]; then
	cd $HOME/.vim/bundle/YouCompleteMe/ && python3 install.py
fi
####################################################################

################## Vim code formatter plugin ######################
if [ -d ~/.vim/bundle/vim-prettier ]; then
	cd $HOME/.vim/bundle/vim-prettier/ && yarn install
fi
####################################################################

################## font (Hermit-Regular) #################
if ! pacman -Qs otf-hermit > /dev/null ; then
	cd $HOME/.bin/
	git clone https://aur.archlinux.org/otf-hermit.git && cd otf-hermit/
	makepkg -sri --noconfirm
fi
####################################################################

cd $srcdir/ && cat ./etc/finished.txt
