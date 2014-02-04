#!/bin/bash -x

EVENTCAM_DIR="/home/ubuntu/eventcam"
while true; do
    rm -f movie_1.mp4
    rm -f action.sh
    #rm -f info.log
    sshpass -p $CAM_PSWD scp  $CAM_ID@se1rver.mailcam.co:/home/$CAM_ID/info.log $EVENTCAM_DIR/
    sshpass -p $CAM_PSWD scp  $CAM_ID@se1rver.mailcam.co:/home/$CAM_ID/new_command.txt $EVENTCAM_DIR/
    cp $EVENTCAM_DIR/new_command.txt $EVENTCAM_DIR/prev_command.txt
#    sshpass -p $CAM_PSWD ssh  $CAM_ID@se1rver.mailcam.co 'rm /home/'$CAM_ID'/info.log'

    awk -f build_action.awk info.log
    chmod 700 action.sh
    ./action.sh
    cp $EVENTCAM_DIR/info.log $EVENTCAM_DIR/info_old.log
done
