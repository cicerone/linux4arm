
BEGIN { FS = ":" } ; 
{ 
    print "#!/bin/bash -x"                                                              >> "action.sh"
#    print "#bibi Email " $2  " CamId " $4 " Password " $6 " Number of pictures " $8 " MovieDuration "  $10 " VideoRecording " $12                                                                            >> "action.sh"

    print "#bibi username " $3 " pswd " $5 " title " $7 " res0 " $9 " email " $11 " res1 " $13 " picnr " $15 " res2 " $17 " movtime " $19 " res3 " $21 " hbeat " $23 " res4 " $25 " action " $27 " res5 " $29 >>  "action.sh"
#:username:abcdefgh:pswd:12345678:title:Motion:res0:0:email:videos4linux@gmail.com:res1:0:picno:1:res2:0:movtime:10:res3:0:hbeat:0:res4:0:action:Start:res5:0:serialno:serial_nr.jpg:

    print "UPDATE_DELAY=60"                                                             >> "action.sh"
    print "if [ '"$27"' != 'Start' ]; then"                                             >> "action.sh"
    print "    sleep $UPDATE_DELAY"                                                     >> "action.sh"
    print "    exit 1;"                                                                 >> "action.sh"
    print "fi"                                                                          >> "action.sh"
    print "if [ '"$3"' != $CAM_ID ]; then"                                              >> "action.sh"
    print "    sleep $UPDATE_DELAY"                                                     >> "action.sh"
    print "    exit 1;"                                                                 >> "action.sh"
    print "fi"                                                                          >> "action.sh"
    print "if [ '"$5"' != $CAM_PSWD ]; then"                                            >> "action.sh"
    print "    sleep $UPDATE_DELAY"                                                     >> "action.sh"
    print "    exit 1;"                                                                 >> "action.sh"
    print "fi"                                                                          >> "action.sh"
    print "if diff info.log info_old.log >/dev/null ; then"                             >> "action.sh"
    print "    echo \"Same info files.\""                                               >> "action.sh" 
    print "else"                                                                        >> "action.sh"
#    print "    mpack -s ecam_params info.log " $11                                      >> "action.sh"
    print "    echo \"Same info files.\""                                               >> "action.sh" 
    print "fi"                                                                          >> "action.sh"

    if ($7 == "Motion")
    {
        print "#Motion"                                                                     >> "action.sh"
        print "PIC_DIR=\"/home/ubuntu/.motion/test\" "                                      >> "action.sh"
        print "PIC_COUNTER=1"                                                               >> "action.sh"
        print "STANDBY_COUNTER=1"                                                           >> "action.sh"
        print "motion -c /home/ubuntu/.motion/motion.conf"                                  >> "action.sh"
        print "while true; do"                                                              >> "action.sh"
        print "       if [ \"$(ls -A $PIC_DIR)\" ]; then"                                   >> "action.sh"
        print "           echo \"WARNING! Motion detected!\""                               >> "action.sh"
        print "           last_file=$(ls -t $PIC_DIR| tail -1)"                             >> "action.sh"
        print "           if [[ \"$PIC_DIR/$last_file\" == *.swf ]]; then"                  >> "action.sh"
        print "               rm -f $PIC_DIR/$last_file"                                    >> "action.sh"
        print "               continue"                                                     >> "action.sh"
        print "           fi"                                                               >> "action.sh"
        #print "           mpack -s picture $PIC_DIR/$last_file " $11                        >> "action.sh"
        #print "           sshpass -p 'roni' scp $PIC_DIR/$last_file roni@192.241.230.171:/home/roni/test_videos" >> "action.sh"
        print "           echo \"$PIC_DIR/$last_file\""                                     >> "action.sh"
        print "           rm -f $PIC_DIR/$last_file"                                        >> "action.sh"
        print "           PIC_COUNTER=$(($PIC_COUNTER+1)) "                                 >> "action.sh"
        print "           if  [ $PIC_COUNTER -gt "$15" ]; then"                             >> "action.sh"
        print "               break"                                                        >> "action.sh"
        print "           fi"                                                               >> "action.sh"
        print "       else"                                                                 >> "action.sh"
        print "           echo \"No motion detected.\""                                     >> "action.sh"
        print "           STANDBY_COUNTER=$(($STANDBY_COUNTER+1)) "                         >> "action.sh"
        print "           if  [ $STANDBY_COUNTER -gt $UPDATE_DELAY ]; then"                 >> "action.sh"
        print "               break"                                                        >> "action.sh"
        print "           fi"                                                               >> "action.sh"
        print "           sleep 1"                                                          >> "action.sh"
        print "       fi"                                                                   >> "action.sh"
        print "done"                                                                        >> "action.sh"

        print "pid=$(head /home/ubuntu/.motion/motion.pid)"                                 >> "action.sh"
        print "echo \"Stop motion program!\""                                               >> "action.sh"
        print "kill -9 $pid"                                                                >> "action.sh"
        print "sleep 1"                                                                     >> "action.sh"
        print "rm -f $PIC_DIR/*"                                                            >> "action.sh"  

        print "if  [ $STANDBY_COUNTER -lt 60 ]; then"                                       >> "action.sh"
        print "    /home/ubuntu/bin/ffmpeg -f video4linux2 -i /dev/video0 -c:v libx264 -t "$19" -pix_fmt yuv420p -preset veryfast -tune fastdecode -profile:v baseline  -r 10 -me_range 4 -x264opts no-deblock movie_1.mp4 " >> "action.sh" 
       #print "    mpack -s video movie_1.mp4 "$11                                          >> "action.sh"
        #print "    mpack -s alarm info.log 4084314892@tmomail.net"                                >> "action.sh"
        print "    movie_file=$(date +\"%m_%d_%Y_%H_%M_%S\").mp4"                           >> "action.sh"
        #print "    sshpass -p 'roni' scp movie_1.mp4 roni@192.241.230.171:/home/roni/test_videos/$movie_file" >> "action.sh"
        print "fi"                                                                          >> "action.sh"
    }
    else if ($7 == "Periodic")
    {
        print "#Periodic"                                                                   >> "action.sh"
        print "PERIOD_COUNTER=1"                                                            >> "action.sh"
        print "PERIOD="$23*10                                                               >> "action.sh"
        print "/home/ubuntu/bin/ffmpeg -f video4linux2 -i /dev/video0 -c:v libx264 -t "$19" -pix_fmt yuv420p -preset veryfast -tune fastdecode -profile:v baseline  -r 10 -me_range 4 -x264opts no-deblock movie_1.mp4 " >> "action.sh" 
#        print "mpack -s video movie_1.mp4 "$11                                         >> "action.sh"
        print "while true; do"                                                          >> "action.sh"
        print "    PERIOD_COUNTER=$(($PERIOD_COUNTER+1)) "                              >> "action.sh"
        print "    if  [ $PERIOD_COUNTER -gt $PERIOD ]; then"                           >> "action.sh"
        print "        break"                                                           >> "action.sh"
        print "    fi"                                                                  >> "action.sh"
        print "    sleep 1"                                                             >> "action.sh"
        print "done"                                                                    >> "action.sh"
    }
    else if ($7 == "Still")
    {
        print "Still"                                                                    >> "action.sh"
        print "PERIOD_COUNTER=1"                                                         >> "action.sh"
        print "INCREMENT_TIME=5"                                                         >> "action.sh"
        print "PERIOD="$23*10                                                            >> "action.sh"
        print "PIC_DIR=\"/home/ubuntu/.motion/test\" "                                   >> "action.sh"
        print "STANDBY_COUNTER=1"                                                        >> "action.sh"
        print "motion -c /home/ubuntu/.motion/motion.conf"                               >> "action.sh"
        print "while true; do"                                                           >> "action.sh"
        print "    sleep $INCREMENT_TIME"                                                              >> "action.sh"
        print "    if [ \"$(ls -A $PIC_DIR)\" ]; then"                                   >> "action.sh"
        print "        PERIOD_COUNTER=1"                                                 >> "action.sh"
        print "        echo \"WARNING! Motion detected!\""                               >> "action.sh"
        print "        rm -f $PIC_DIR/*"                                                 >> "action.sh"
        print "        STANDBY_COUNTER=$(($STANDBY_COUNTER+$INCREMENT_TIME)) "                         >> "action.sh"
        print "        if  [ $STANDBY_COUNTER -gt $UPDATE_DELAY ]; then"                 >> "action.sh"
        print "            pid=$(head /home/ubuntu/.motion/motion.pid)"                  >> "action.sh"
        print "            echo \"Stop motion program!\""                                >> "action.sh"
        print "            kill -9 $pid"                                                 >> "action.sh"
        print "            sleep 1"                                                      >> "action.sh"
        print "            break"                                                        >> "action.sh"
        print "        fi"                                                               >> "action.sh"
        print "        sleep 1"                                                          >> "action.sh"
        print "    else"                                                                 >> "action.sh"
        print "        echo \"No motion detected.\""                                     >> "action.sh"
        print "        PERIOD_COUNTER=$(($PERIOD_COUNTER+$INCREMENT_TIME)) "                           >> "action.sh"
        print "        if  [ $PERIOD_COUNTER -gt $PERIOD ]; then"                        >> "action.sh"
        print "            pid=$(head /home/ubuntu/.motion/motion.pid)"                  >> "action.sh"
        print "            echo \"Stop motion program!\""                                >> "action.sh"
        print "            kill -9 $pid"                                                 >> "action.sh"
        print "            sleep 1"                                                      >> "action.sh"
        print "            /home/ubuntu/bin/ffmpeg -f video4linux2 -i /dev/video0 -c:v libx264 -t "$19" -pix_fmt yuv420p -preset veryfast -tune fastdecode -profile:v baseline  -r 10 -me_range 4 -x264opts no-deblock movie_1.mp4 " >> "action.sh" 
#        print "            mpack -s video movie_1.mp4 "$11                               >> "action.sh"
        print "            break"                                                        >> "action.sh"
        print "        fi"                                                               >> "action.sh"
        print "        sleep 1"                                                          >> "action.sh"
        print "    fi"                                                                   >> "action.sh"
        print "done"                                                                     >> "action.sh"
    }
}
