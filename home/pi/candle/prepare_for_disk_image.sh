#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run with sudo"
  exit
fi

# prepare for factory reset script
touch /boot/developer.txt # will cause the real factory_reset script to also write zeroes to empty space
rm /home/pi/.webthings/candle.log
rm /boot/candle_log.txt
rm /boot/candle_issues.txt
rm /boot/candle_fix.txt
rm /boot/candle_fix_failed.txt
rm /boot/debug.txt
rm /boot/raspinfo.txt
rm /boot/candle_cutting_edge.txt
rm /boot/keep_z2m.txt
rm /boot/keep_bluetooth.txt
rm /boot/candle_first_run_complete.txt
rm /boot/candle_original_version.txt
rm /boot/candle_rw_keep.txt
rm /boot/candle_rw_once.txt
rm /boot/tunnel.txt
rm /etc/asound.conf
rm /var/log/*

# Clean NPM cache
export NVM_DIR="/home/pi/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
npm cache clean --force # already done in install_candle_controller script
#rm /home/pi/.npm/anonymous-cli-metrics.json 

if [ -f /home/pi/candle/candle_first_run.sh ]; then
  rm /boot/candle_first_run.sh
  cp /home/pi/candle/candle_first_run.sh /boot/candle_first_run.sh
else
  echo "ERROR, candle_first_run.sh is missing"
  exit 1
fi
rm /home/pi/.fehbg

rm /home/pi/.wget-hsts

rm -rf /home/pi/.pki

find /tmp -type f -atime +10 -delete

echo "Well hello there" > /home/pi/.bash_history

chmod +x /home/pi/.webthings/addons/power-settings/factory_reset.sh
/home/pi/.webthings/addons/power-settings/factory_reset.sh
