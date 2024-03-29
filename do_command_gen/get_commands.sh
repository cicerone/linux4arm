#!/bin/bash 

NEW_EMAIL_DIR="/home/cabsibia/Maildir/new"
OLD_EMAIL_DIR="/home/cabsibia/Maildir/cur"
MAILCAM_DIR="/home/cabsibia/mail_cam"
PATTERN="servername"

while true; do

# look for empty dir 
    if [ "$(ls -A $NEW_EMAIL_DIR)" ]; then
        #echo "Take action $NEW_EMAIL_DIR is not Empty"
        rm -f $MAILCAM_DIR/email.log
        rm -f $MAILCAM_DIR/info.log
        rm -f $MAILCAM_DIR/partial_email.log
        rm -f $MAILCAM_DIR/id_passwd_path.log
        rm -f $MAILCAM_DIR/serial_nr.jpg
        last_file=$(ls -t $NEW_EMAIL_DIR| tail -1)
        if grep -q $PATTERN $NEW_EMAIL_DIR/$last_file; then
            sed '/username/!d' $NEW_EMAIL_DIR/$last_file > $MAILCAM_DIR/email.log
            ./check_commands.py
            ./copy_commands.py
            #mv  $NEW_EMAIL_DIR/$last_file $OLD_EMAIL_DIR/$last_file 
            rm  -f $NEW_EMAIL_DIR/$last_file 
            #echo "info.log is ready!"
        else
            sleep 1
        fi
    fi
    sleep 1 
done



