#!/bin/bash
while true; do
    rm -f final_loop.sh
    rm -f email.log
    rm -f info.log
    curl -u testfswebcam:asdfasdfasdf --silent "https://mail.google.com/mail/feed/atom" | grep summary > email.log
    head -n 1 email.log > info.log
    awk -f build_fswebcam.awk info.log
    chmod 777 final_loop.sh
    ./final_loop.sh
    mpack -s video movie_1.mp4 videos4linux@gmail.com
    sleep 10 
done
