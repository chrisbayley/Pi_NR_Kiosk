#!/bin/bash
#
# kiosk.sh :: start a web browser in Kiosk mode
#

# --- Configuration variables
export DISPLAY=":1"
BROWSER="/usr/bin/chromium-browser --window-size=800,480 --kiosk --window-position=0,0"
STARTPAGE="http://localhost:1880/ui"

HOMEPAGE="http://yellow/"
WARN="file:/usr/local/kiosk/outage_warning.html"
XSERVER="/usr/bin/X"
XMODMAP="/usr/bin/xmodmap /usr/local/kiosk/xmodmap.txt"
SCREENSAVER="/usr/bin/xscreensaver -nosplash"
SCREENSETUP="xsetroot -cursor_name left_ptr -solid blue" SECONDS="15"
CHECK="curl $HOMEPAGE --head --max-time 1"
# --- End of configuration variables

while true
do
   # set the backlight to reasonable
   sudo sh -c "echo 100 > /sys/class/backlight/rpi_backlight/brightness"

   # Step 1: Start the X server, allowing local connections only
   $XSERVER $DISPLAY -nolisten tcp -ac -terminate &
   XPID=$!

   # Hide the mouse from the display
   unclutter &

   # Step 2: Start the screensaver
   # $SCREENSAVER &

   # Step 3: Adjust the keymapping, pointer configuration, mouse shape,
   # and root window color
   # $XMODMAP
   # $SCREENSETUP

   # Step 4: Start the browser
   $BROWSER $STARTPAGE &
   BROWSERPID=$!

   # Step 5: Start the network monitoring code
   # (
   #     sleep 10        # Give the browser a chance to start
   #     STATE="UP"
   #     while sleep $SECONDS
   #     do
   #         $CHECK
   #         RESULT=$?
   #         case "$STATE" in
   #         "UP")
   #             if [ "$RESULT" -ne "0" ]
   #             then
   #                 firefox -remote "openurl($WARN)"
   #                 STATE="DOWN"
   #
   #         fi
   #         ;;
   #         "DOWN")
   #             if [ "$RESULT" -eq 0 ]
   #             then
   #                 firefox -remote "openurl($HOMEPAGE)"
   #                 STATE="UP"
   #          fi
   #          ;;
   #          esac
   #     done
   # )&

   # Step 6: Wait until the application dies
   wait $BROWSERPID

   # Step 7: Kill everything and start over
   killall -KILL $BROWSERPID $XPID
done
