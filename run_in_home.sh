#!/bin/bash

if [ "$EUID" == "0" ]
  then echo -en "\nRoot user detected. Typically install as a normal user. No need for sudo.\r\n"
  read -p "Are you really sure you want to install as root ? (y/N) ? " yn
  case $yn in
    [Yy]* )
    ;;
    * )
      exit
    ;;
  esac
fi

sudo apt-get update
sudo apt-get --yes upgrade
sudo apt-get autoremove
sudo apt-get clean

bash <(curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered)

sudo npm i -g --unsafe-perm  node-red-dashboard
sudo npm i -g --unsafe-perm  node-red-contrib-xbee
# sudo npm i -g serialport
sudo npm i -g --unsafe-perm  xbee-api


sudo systemctl enable nodered

sudo apt-get install --yes git
git config --global alias.st status
git config --global alias.ci commit
git config --global alias.co checkout
git config --global user.name "Chris BAYLEY"
git config --global user.email "chris@codeweaver.co.nz"
git config --global color.ui always
git config --global push.default current
git config --global log.decorate full
git config --global branch.rebase true
git config --global branch.autosetuprebase always

ssh-keygen
cat .ssh/id_rsa.pub

## get a node-red project into .node-red
git clone https://github.com/chrisbayley/WaterSys104EVR.git .node-red

## disable some unneeded services
sudo systemctl disable avahi-daemon
sudo systemctl disable serial-getty@ttyAMA0.service

## install minimal Xserver
sudo apt-get install --yes --no-install-recommends xserver-xorg
sudo apt-get install --yes --no-install-recommends xinit
sudo apt-get install --yes --no-install-recommends xdotool
sudo apt-get install --yes --no-install-recommends unclutter
sudo apt-get install --yes --no-install-recommends xserver-xorg-legacy
sudo apt-get install --yes --no-install-recommends chromium-browser

## get the kisok script
curl -O https://raw.githubusercontent.com/chrisbayley/Pi_NR_Kiosk/master/kiosk.sh
chmod +x kiosk.sh

## make it the default Xsession
ln -sf kiosk.sh .Xsession

#get bash to startx
echo '[ "$(tty)" = "/dev/tty1" ] && exec startx' >> .profile

# allow anybody to startx
sudo sed -i.bak -e 's/\(^allowed_users\)=.*/\1=anybody/' /etc/X11/Xwrapper.config

# sort out some device permissions
sudo sh -c 'echo SUBSYSTEM==\"backlight\", GROUP=\"video\" > /etc/udev/rules.d/50-backlight.rules'

## set to autologin
sudo raspi-config nonint do_boot_behaviour B2

echo "DONE: Now so 'sudo reboot'"
