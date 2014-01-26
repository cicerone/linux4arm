#!/bin/bash -x

INFO_DIR="/home/ubuntu/eventcam"
while true; do
    rm -f movie_1.mp4
    rm -f action.sh
#    rm -f info.log
    sshpass -p $CAM_PSWD scp  $CAM_ID@se1rver.mailcam.co:/home/$CAM_ID/info.log $INFO_DIR/info.log
    awk -f build_action.awk info.log
    chmod 700 action.sh
    ./action.sh
    cp $INFO_DIR/info.log $INFO_DIR/info_old.log
done
