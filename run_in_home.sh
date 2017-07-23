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

# sudo apt-get update
# sudo apt-get upgrade
# sudo apt-get autoremove
# sudo apt-get clean
#
# bash <(curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered)

# sudo npm i -g --unsafe-perm  node-red-dashboard
# sudo npm i -g --unsafe-perm  node-red-contrib-xbee
# # sudo npm i -g serialport
# sudo npm i -g --unsafe-perm  xbee-api
#

sudo systemctl enable nodered

sudo apt-get install git
git config --global alias.st status
git config --global alias.ci commit
# git config --global user.name "Chris BAYLEY"
# git config --global user.email "chris@codeweaver.co.nz"
git config --global color.ui always
git config --global push.default current
git config --global log.decorate full
git config --global branch.rebase true
git config --global branch.autosetuprebase always

ssh-keygen
cat .ssh/id_rsa.pub

# mkdir .node-red
# cd .node-red/
# git clone git@github.com:chrisbayley/WaterSys104EVR.git
git clone https://github.com/chrisbayley/WaterSys104EVR.git .node-red

# cd
#mkdir nodes
#cd nodes
#git clone git@github.com:chrisbayley/NR-XBeeAPI.git
#git clone https://github.com/chrisbayley/NR-XBeeAPI.git

sudo systemctl disable avahi-daemon
sudo systemctl disable serial-getty@ttyAMA0.service

## sort perms on serial port
#sudo adduser pi tty
#sudo chmod g+r /dev/ttyS0

## install minimal Xserver
sudo apt-get install --yes --no-install-recommends xserver-xorg
sudo apt-get install --yes --no-install-recommends xinit
sudo apt-get install --yes --no-install-recommends xdotool
sudo apt-get install --yes --no-install-recommends unclutter
sudo apt-get install --yes --no-install-recommends xserver-xorg-legacy
sudo apt-get install --yes --no-install-recommends chromium-browser

## get the kisok script
curl -O https://raw.githubusercontent.com/chrisbayley/Pi_NR_Kiosk/master/kiosk.sh

## make it the default Xsession
ln -sf kiosk.sh .Xsession

# sudo nano Xwrapper.config
sudo sh -c "echo -ne '\nallowed_users=anybody\n' >> /etc/X11/Xwrapper.config"


sudo sh -c 'echo SUBSYSTEM==\"backlight\", GROUP=\"video\" > 50-backlight.rules'

# sudo reboot
