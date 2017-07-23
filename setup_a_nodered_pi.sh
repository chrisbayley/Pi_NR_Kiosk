#!/bin/bash

if [ "$(id -u)" != "0" ]
 then
   echo "Please run as root"
   exit 1
fi

if false
 then
    false

apt-get update
apt-get upgrade
apt-get autoremove
sudo apt-get clean

fi

bash <(curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered)
# systemctl start nodered
#
# apt-get install git
# git config --global alias.st status
# git config --global alias.ci commit
# git config --global user.name "Chris BAYLEY"
# git config --global user.email "chris@codeweaver.co.nz"
# git config --global color.ui always
# git config --global push.default current
# git config --global log.decorate full
# git config --global branch.rebase true
# git config --global branch.autosetuprebase always
#
# ssh-keygen
# cat .ssh/id_rsa.pub
# cd .node-red/
#
# git clone git@github.com:chrisbayley/WaterSys104EVR.git
# mkdir nodes
# cd nodes
# git clone git@github.com:chrisbayley/NR-XBeeAPI.git
# vi settings.js
# bash <(curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered)
# sudo npm i -g serialport
# sudo systemctl disable avahi-daemon
# sudo systemctl stop avahi-daemon
# sudo adduser pi tty
# sudo systemctl stop serial-getty@ttyAMA0.service
# sudo systemctl disable serial-getty@ttyAMA0.service
# sudo chmod g+r /dev/ttyS0
# #npm install serialport@4.0.7
# nano /boot/cmdline.txt
# sudo nano /boot/cmdline.txt
# reboot
# sudo apt-get install --no-install-recommends xserver-xorg
# sudo apt-get install --no-install-recommends xinit
# sudo apt-get install --no-install-recommends chromium-browser
# sudo apt-get install --no-install-recommends xdotool
# sudo apt-get install --no-install-recommends unclutter
# sudo apt-get install xserver-xorg-lagacy
# #get ./kiosk.sh
# sudo nano Xwrapper.config
# sudo sh -c "echo 100 > /sys/class/backlight/rpi_backlight/brightness"
# sudo systemctl enable nodered.service
# sudo systemctl start nodered.service
# #sudo reboot
