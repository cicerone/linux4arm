#!/bin/bash -x
while true; do
    rm -f final_loop.sh
    rm -f email.log
    rm -f info.log
#    curl -u roni:roni --silent http://mailcam.co/mail_cam/d$CAM_ID/info.log | grep summary > email.log
    sshpass -p 'roni' scp  roni@192.241.230.171:/var/www/mail_cam/d$CAM_ID/info.log /home/ubuntu/webcam/email.log
    head -n 1 email.log > info.log
    awk -f build_fswebcam.awk info.log
    chmod 700 final_loop.sh
    ./final_loop.sh
#FIXME add the right email
#    mpack -s video movie_1.mp4 cicerone.mihalache@gmail.com
    sleep 10 
done
