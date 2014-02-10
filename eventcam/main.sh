#!/bin/bash -x

EVENTCAM_DIR="/home/ubuntu/eventcam"

while true; do
    rm -f *.mp4
    sshpass -p $CAM_PSWD scp $CAM_ID@se1rver.mailcam.co:/home/$CAM_ID/new_command.txt $EVENTCAM_DIR/
    if diff new_command.txt prev_command.txt > /dev/null ; then
        echo \"Same cmd files.\"                              
    else                                                      
        echo \"New cmd file.\"                                
        sshpass -p $CAM_PSWD scp $CAM_ID@se1rver.mailcam.co:/home/$CAM_ID/action.sh $EVENTCAM_DIR/
        cp $EVENTCAM_DIR/new_command.txt $EVENTCAM_DIR/prev_command.txt
    fi                                                        
    ./action.sh
done
