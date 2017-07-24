#!/bin/bash

# Run this script in display 0 - the monitor
export DISPLAY=:0

# set the backlight to reasonable
sudo sh -c "echo 100 > /sys/class/backlight/rpi_backlight/brightness"

# Hide the mouse from the display
unclutter &

#wait for NodeRED to start
while ! nc -w 1 -z localhost 1880; do   
  sleep 0.1 # wait for 1/10 of the second before check again
done

# If Chrome crashes (usually due to rebooting), clear the crash flag so we don't have the annoying warning bar
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/pi/.config/chromium/Default/Preferences

# Run Chromium and open tabs
/usr/bin/chromium-browser --window-size=800,480 --kiosk --window-position=0,0 http://localhost:1880/ui &

# Start the kiosk loop. This keystroke changes the Chromium tab
# To have just anti-idle, use this line instead:
# xdotool keydown ctrl; xdotool keyup ctrl;
# Otherwise, the ctrl+Tab is designed to switch tabs in Chrome
# #
while (true)
 do
  xdotool keydown ctrl; xdotool keyup ctrl;
  sleep 15
done
