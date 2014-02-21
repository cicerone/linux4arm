#!/bin/bash -x

NEW_EMAIL_DIR="/home/suse465/Maildir/new"
OLD_EMAIL_DIR="/home/suse465/Maildir/cur"
DMUX_DIR="/home/suse465/dmux"

while true; do

# look for empty dir 
    if [ "$(ls -A $NEW_EMAIL_DIR)" ]; then
        echo "Take action $NEW_EMAIL_DIR is not Empty"
        #sleep 1
        rm -f $DMUX_DIR/email.log
        rm -f $DMUX_DIR/info.log
        rm -f $DMUX_DIR/partial_email.log
        rm -f $DMUX_DIR/id_passwd_path.log
        rm -f $DMUX_DIR/serial_nr.jpg
        last_file=$(ls -t $NEW_EMAIL_DIR| tail -1)
        sed '/Start\|Stop/!d' $NEW_EMAIL_DIR/$last_file > $DMUX_DIR/partial_email.log
        sed '/http/!d' $NEW_EMAIL_DIR/$last_file > $DMUX_DIR/id_passwd_path.log
        sed '/Subject/!d' $NEW_EMAIL_DIR/$last_file > $DMUX_DIR/sender_ip.log
        ./dispach_to_server.py
        #mv  $NEW_EMAIL_DIR/$last_file $OLD_EMAIL_DIR/$last_file 
        rm  -f $NEW_EMAIL_DIR/$last_file 
        rm  -f $DMUX_DIR/../sent
        #echo "email.log is ready!"
    fi
    sleep 1 
done



