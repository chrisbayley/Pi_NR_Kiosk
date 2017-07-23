#!/bin/bash

## remove the kernel's serial console
sed -i.bak -e 's/console=serial0,[0-9]* //' cmdline.txt

## Enable the ttyS0 for general use
CONFIG_FILE="config.txt"
UART_TXT="enable_uart"
if grep --silent ${UART_TXT} $CONFIG_FILE
then
	sed -i.bak -e "s/^\(${UART_TXT}\)=./\1=1/" $CONFIG_FILE
else
	echo -en "\n# Enable the serial port\n${UART_TXT}=1\n" >> $CONFIG_FILE
fi

## Enable ssh
touch ssh

## Add details for hands free wifi login
curl -O https://raw.githubusercontent.com/chrisbayley/Pi_NR_Kiosk/master/wpa_supplicant.conf
