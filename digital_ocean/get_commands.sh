#!/bin/bash -x
while true; do
    rm -f email.log
    rm -f info.log
    curl -u testfswebcam:asdfasdfasdf --silent "https://mail.google.com/mail/feed/atom" | grep summary > email_new.log
    diff email_new.log email_old.log | tail -n +2  > email.log
    ./check_commands.py
    ./copy_commands.py

#   sleep 1
#   if [ -s info.log ]; then
#       cp -f info.log /var/www/mailcam.co/public_html/mail_cam/d000000
#   fi
    cp -f email_new.log email_old.log
    echo "info.log is ready!"
#    head -n 1 email.log > info.log

    sleep 10 
done
