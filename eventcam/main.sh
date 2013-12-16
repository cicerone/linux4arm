#!/bin/bash -x
while true; do
    rm -f movie_1.mp4
    rm -f movie_1.avi
    rm -f action.sh
    rm -f email.log
    rm -f info.log
#    curl -u roni:roni --silent http://mailcam.co/mail_cam/d$CAM_ID/info.log | grep summary > email.log
    sshpass -p $CAM_PSWD scp  $CAM_ID@192.241.230.171:/home/$CAM_ID/info.log /home/ubuntu/eventcam/email.log
    head -n 1 email.log > info.log
    awk -f build_action.awk info.log
    chmod 700 action.sh
    ./action.sh
    sleep 1 
done
