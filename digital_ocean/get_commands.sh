#!/bin/bash -x

NEW_EMAIL_DIR="/home/roni/Maildir/new"
OLD_EMAIL_DIR="/home/roni/Maildir/cur"
MAILCAM_DIR="/home/roni/mail_cam"

while true; do

# look for empty dir 
    if [ "$(ls -A $NEW_EMAIL_DIR)" ]; then
        echo "Take action $NEW_EMAIL_DIR is not Empty"
        sleep 1
        rm -f $MAILCAM_DIR/email.log
        rm -f $MAILCAM_DIR/info.log
        rm -f $MAILCAM_DIR/partial_email.log
        rm -f $MAILCAM_DIR/id_passwd_path.log
        rm -f $MAILCAM_DIR/serial_nr.jpg
        last_file=$(ls -t $NEW_EMAIL_DIR| tail -1)
        sed '/Start\|Stop/!d' $NEW_EMAIL_DIR/$last_file > $MAILCAM_DIR/partial_email.log
        sed '/http/!d' $NEW_EMAIL_DIR/$last_file > $MAILCAM_DIR/id_passwd_path.log
        ./build_one_line_info.py
        ./check_commands.py
        ./copy_commands.py
        mv  $NEW_EMAIL_DIR/$last_file $OLD_EMAIL_DIR/$last_file 
        echo "info.log is ready!"
    else
        echo "$NEW_EMAIL_DIR is Empty"
    fi

    sleep 1 
done



