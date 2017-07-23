# Pi_NR_Kiosk

Write the jessie image
mount the boot part
cd /boot
touch ssh
curl -O https://raw.githubusercontent.com/chrisbayley/Pi_NR_Kiosk/master/wpa_supplicant.conf

cat ~/.ssh/id_rsa.pub | ssh pi 'mkdir .ssh && cat >> .ssh/authorized_keys && echo "Public key successfully copied"'
