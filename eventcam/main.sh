#!/bin/bash -x

EVENTCAM_DIR="/home/ubuntu/eventcam"
PATTERN="======="
FILE_NC="new_command.txt"
FILE_PC="prev_command.txt"

while true; do
    rm -f *.mp4
    rm -f *.jpg
    sshpass -p $CAM_PSWD scp $CAM_ID@$CSERVER_ID.mailcam.co:/home/$CAM_ID/$FILE_NC $EVENTCAM_DIR/

    if grep -q $PATTERN $FILE_NC; then
        # file contains pattern
        if diff $FILE_NC $FILE_PC > /dev/null ; then
            echo \"Same cmd files.\"                              
        else                                                      
            echo \"New cmd file.\"                                
            sshpass -p $CAM_PSWD scp $CAM_ID@$CSERVER_ID.mailcam.co:/home/$CAM_ID/action.sh $EVENTCAM_DIR/
            cp $EVENTCAM_DIR/$FILE_NC $EVENTCAM_DIR/$FILE_PC
        fi                                                        
        ./action.sh
    else
        sleep 1
    fi
done

