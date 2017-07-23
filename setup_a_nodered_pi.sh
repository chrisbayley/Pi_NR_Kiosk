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
sudo apt-get upgrade
sudo apt-get autoremove
sudo apt-get clean

bash <(curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered)

sudo npm i -g --unsafe-perm --no-progress node-red-dashboard
sudo npm i -g --unsafe-perm --no-progress node-red-contrib-xbee

# remove the kernel serial console
sudo sed -ibak -re 's/console=serial0,[0-9]+ //' /boot/cmdline.txt

## Enable the ttyS0 for general use
CONFIG_FILE="/boot/config.txt"
UART_TXT="enable_uart"
if grep --silent ${UART_TXT} $CONFIG_FILE
then
	sudo sed -i.bak -e "s/^\(${UART_TXT}\)=./\1=1/" $CONFIG_FILE
else
	sudo echo -en "\n# Enable the serial port\n${UART_TXT}=1\n" >> $CONFIG_FILE
fi

systemctl enable nodered

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

mkdir .node-red
cd .node-red/
# git clone git@github.com:chrisbayley/WaterSys104EVR.git
git clone https://github.com/chrisbayley/WaterSys104EVR.git

mkdir nodes
cd nodes
#git clone git@github.com:chrisbayley/NR-XBeeAPI.git
git clone https://github.com/chrisbayley/NR-XBeeAPI.git

# sudo npm i -g serialport
sudo systemctl disable avahi-daemon
# sudo systemctl stop avahi-daemon
sudo adduser pi tty
# sudo systemctl stop serial-getty@ttyAMA0.service
sudo systemctl disable serial-getty@ttyAMA0.service
sudo chmod g+r /dev/ttyS0
# #npm install serialport@4.0.7
# reboot


sudo apt-get install --no-install-recommends xserver-xorg
sudo apt-get install --no-install-recommends xinit
sudo apt-get install --no-install-recommends xdotool
sudo apt-get install --no-install-recommends unclutter
sudo apt-get install --no-install-recommends xserver-xorg-legacy
sudo apt-get install --no-install-recommends chromium-browser

cd
git clone https://raw.githubusercontent.com/chrisbayley/Pi_NR_Kiosk/master/kiosk.sh


# sudo nano Xwrapper.config
sudo sh -c "echo -ne '\nallowed_users=anybody\n' >> /etc/X11/Xwrapper.config"

sudo sh -c "echo 100 > /sys/class/backlight/rpi_backlight/brightness"

# sudo reboot
