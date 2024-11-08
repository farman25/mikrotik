#!/bin/bash

username="$1"

pkgs=('git' 'neofetch' 'virglrenderer-android' 'papirus-icon-theme' 'xfce4' 'xfce4-goodies' 'eza' 'pavucontrol-qt' 'bat' 'jq' 'nala' 'wmctrl' 'firefox' 'netcat-openbsd' 'termux-x11-nightly' 'eza')

#Install xfce4 desktop and additional packages
pkg install "${pkgs[@]}" -y -o Dpkg::Options::="--force-confold"

#Put Firefox icon on Desktop
cp $PREFIX/share/applications/firefox.desktop $HOME/Desktop 
chmod +x $HOME/Desktop/firefox.desktop

#Put WPS Icon on Dekstop
cp $PREFIX/share/applications/wps-office-wps.desktop $HOME/Desktop 
chmod +x $HOME/Desktop/wps-office-wps.desktop

#Set aliases
echo "
alias debian='proot-distro login debian --user $username --shared-tmp'
#alias zrun='proot-distro login debian --user $username --shared-tmp -- env DISPLAY=:1.0 MESA_LOADER_DRIVER_OVERRIDE=zink TU_DEBUG=noconform '
#alias zrunhud='proot-distro login debian --user $username --shared-tmp -- env DISPLAY=:1.0 MESA_LOADER_DRIVER_OVERRIDE=zink TU_DEBUG=noconform GALLIUM_HUD=fps '
alias hud='GALLIUM_HUD=fps '
alias ls='eza -lF --icons'
alias cat='bat '
alias apt='nala '
alias install='nala install -y '
alias uninstall='nala remove -y '
alias search='nala search '
alias list='nala list --upgradeable'
alias show='nala show'
" >> $PREFIX/etc/bash.bashrc

#Download Wallpaper
wget https://raw.githubusercontent.com/wahyu22010/Debian/main/peakpx.jpg
wget https://raw.githubusercontent.com/wahyu22010/Debian/main/dark_waves.png
mv peakpx.jpg $PREFIX/share/backgrounds/xfce/
mv dark_waves.png $PREFIX/share/backgrounds/xfce/

#Install WhiteSur-Dark Theme
wget https://github.com/vinceliuice/WhiteSur-gtk-theme/archive/refs/tags/2023-04-26.zip
unzip 2023-04-26.zip
tar -xf WhiteSur-gtk-theme-2023-04-26/release/WhiteSur-Dark-44-0.tar.xz
mv WhiteSur-Dark/ $PREFIX/share/themes/
rm -rf WhiteSur*
rm 2023-04-26.zip

#Install Fluent Cursor Icon Theme
wget https://github.com/vinceliuice/Fluent-icon-theme/archive/refs/tags/2023-02-01.zip
unzip 2023-02-01.zip
mv Fluent-icon-theme-2023-02-01/cursors/dist $PREFIX/share/icons/ 
mv Fluent-icon-theme-2023-02-01/cursors/dist-dark $PREFIX/share/icons/
rm -rf $HOME//Fluent*
rm 2023-02-01.zip

#Setup Fonts
wget https://github.com/microsoft/cascadia-code/releases/download/v2111.01/CascadiaCode-2111.01.zip
mkdir .fonts 
unzip CascadiaCode-2111.01.zip
mv otf/static/* .fonts/ && rm -rf otf
mv ttf/* .fonts/ && rm -rf ttf/
rm -rf woff2/ && rm -rf CascadiaCode-2111.01.zip

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Meslo.zip
unzip Meslo.zip
mv *.ttf .fonts/
rm Meslo.zip
rm LICENSE.txt
rm readme.md

wget https://github.com/gorontaloku/Asset-linux/raw/main/font-windows1.zip
unzip font-windows1.zip
mv font-windows1*.ttf .fonts/
mv font-windows1*.otf .fonts/
rm font-windows1.zip

wget https://github.com/gorontaloku/Asset-linux/raw/main/font-windows2.zip
unzip font-windows2.zip
mv font-windows2*.ttf .fonts/
mv font-windows2*.otf .fonts/
rm font-windows2.zip

wget https://github.com/gorontaloku/Asset-linux/raw/main/font-windows3.zip
unzip font-windows3.zip
mv font-windows3*.ttf .fonts/
mv font-windows3*.otf .fonts/
rm font-windows3.zip

wget https://github.com/gorontaloku/Asset-linux/raw/main/font-windows4.zip
unzip font-windows4.zip
mv font-windows4*.ttf .fonts/
mv font-windows4*.otf .fonts/
rm font-windows4.zip

wget https://github.com/gorontaloku/Asset-linux/raw/main/font-windows5.zip
unzip font-windows5.zip
mv font-windows5*.ttf .fonts/
rm font-windows5.zip

wget https://github.com/gorontaloku/Asset-linux/raw/main/font-windows6.zip
unzip font-windows6.zip
mv font-windows6*.ttf .fonts/
mv font-windows6*.otf .fonts/
rm font-windows6.zip

wget https://github.com/gorontaloku/Asset-linux/raw/main/font-windows7.zip
unzip font-windows7.zip
mv font-windows7*.ttf .fonts/
mv font-windows7*.otf .fonts/
rm font-windows7.zip

wget https://github.com/wahyu22010/Debian/raw/main/NotoColorEmoji-Regular.ttf
mv NotoColorEmoji-Regular.ttf .fonts

wget https://github.com/wahyu22010/Debian/raw/main/font.ttf
mv font.ttf .termux/font.ttf

#Setup Fancybash Termux
wget https://raw.githubusercontent.com/wahyu22010/Debian/main/fancybash.sh
mv fancybash.sh .fancybash.sh
echo "source $HOME/.fancybash.sh" >> $PREFIX/etc/bash.bashrc
sed -i "326s/\\\u/$username/" $HOME/.fancybash.sh
sed -i "327s/\\\h/termux/" $HOME/.fancybash.sh

#Autostart Conky
wget https://github.com/wahyu22010/Debian/raw/main/config.tar.gz
tar -xvzf config.tar.gz
rm config.tar.gz
chmod +x .config/autostart/conky.desktop
