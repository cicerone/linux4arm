
BEGIN { FS = ":" } ; 
{ 
    print "#!/bin/bash -x"                                                              >> "action.sh"
    print "#bibi username " $3 " pswd " $5 " title " $7 " res0 " $9 " email " $11 " res1 " $13 " picnr " $15 " delay " $17 " movtime " $19 " res3 " $21 " hbeat " $23 " res4 " $25 " action " $27 " res5 " $29 >>  "action.sh"
#:username:abcdefgh:pswd:12345678:title:Motion:res0:0:email:videos4linux@gmail.com:res1:0:picno:1:res2:0:movtime:10:res3:0:hbeat:0:res4:0:action:Start:res5:0:serialno:serial_nr.jpg:

    print "UPDATE_DELAY=20"                                                             >> "action.sh"
    print "HBMOVIE_DURATION=3"                                                          >> "action.sh"
    print "PERIOD="$23*60                                                               >> "action.sh"
    print "EVENTCAM_DIR=\"/home/ubuntu/eventcam\" "                                      >> "action.sh"
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

    if ($7 == "Motion")
    {
        print "#Motion"                                                                     >> "action.sh"
        print "PERIOD_COUNTER=1"                                                            >> "action.sh"
        print "PIC_DIR=\"/home/ubuntu/.motion/test\" "                                      >> "action.sh"
        print "PIC_COUNTER=1"                                                               >> "action.sh"
        print "STANDBY_COUNTER=1"                                                           >> "action.sh"
        print "motion -c /home/ubuntu/.motion/motion.conf"                                  >> "action.sh"
        print "while true; do"                                                              >> "action.sh"
        print "       if [ \"$(ls -A $PIC_DIR)\" ]; then"                                   >> "action.sh"
        print "           echo \"WARNING! Motion detected!\""                               >> "action.sh"
        print "           PERIOD_COUNTER=1"                                                 >> "action.sh"
        print "           last_file=$(ls -t $PIC_DIR| tail -1)"                             >> "action.sh"
        print "           if [[ \"$PIC_DIR/$last_file\" == *.swf ]]; then"                  >> "action.sh"
        print "               rm -f $PIC_DIR/$last_file"                                    >> "action.sh"
        print "               continue"                                                     >> "action.sh"
        print "           fi"                                                               >> "action.sh"
        #print "           mpack -s picture $PIC_DIR/$last_file " $11                       >> "action.sh"
        print "            sshpass -p $CAM_PSWD scp $PIC_DIR/$last_file $CAM_ID@se1rver.mailcam.co:/home/$CAM_ID/pic.jpg"                                                                                        >> "action.sh"  
        print "            sshpass -p $CAM_PSWD scp $EVENTCAM_DIR/new_command.txt $CAM_ID@se1rver.mailcam.co:/home/$CAM_ID/"                                                                                     >> "action.sh"  
        print "            sshpass -p $CAM_PSWD ssh $CAM_ID@se1rver.mailcam.co 'mutt -s \"mutt inel\" -a ~/pic.jpg -- "$11" < ~/new_command.txt'"                                                                >> "action.sh"
        print "           echo \"$PIC_DIR/$last_file\""                                     >> "action.sh"
        print "           rm -f $PIC_DIR/$last_file"                                        >> "action.sh"
        print "           PIC_COUNTER=$(($PIC_COUNTER+1)) "                                 >> "action.sh"
        print "           if  [ $PIC_COUNTER -gt "$15" ]; then"                             >> "action.sh"
        print "               break"                                                        >> "action.sh"
        print "           fi"                                                               >> "action.sh"
        print "       else"                                                                 >> "action.sh"
        print "           echo \"No motion detected.\""                                     >> "action.sh"
        print "           PERIOD_COUNTER=$(($PERIOD_COUNTER+1)) "                           >> "action.sh"
        print "           if  [ $PERIOD_COUNTER -gt $PERIOD ]; then"                        >> "action.sh"
        print "               PERIOD_COUNTER=1"                                             >> "action.sh"
        print "               pid=$(head /home/ubuntu/.motion/motion.pid)"                  >> "action.sh"
        print "               echo \"Stop motion program!\""                                >> "action.sh"
        print "               kill -9 $pid"                                                 >> "action.sh"
        print "               rm -f movie_1.mp4 "                                           >> "action.sh"
        print "               /home/ubuntu/bin/ffmpeg -f video4linux2 -i /dev/video0 -c:v libx264 -t $HBMOVIE_DURATION -pix_fmt yuv420p -preset veryfast -tune fastdecode -profile:v baseline  -r 10 -me_range 4 -x264opts no-deblock movie_1.mp4 " >> "action.sh" 
        print "               sshpass -p $CAM_PSWD scp $EVENTCAM_DIR/movie_1.mp4 $CAM_ID@se1rver.mailcam.co:/home/$CAM_ID/"                                                                                      >> "action.sh"  
        print "               sshpass -p $CAM_PSWD ssh $CAM_ID@se1rver.mailcam.co 'mutt -s \"test mutt inel\" -a ~/movie_1.mp4 -- "$11" < ~/new_command.txt'"                                                    >> "action.sh"
        print "               echo \"Start motion program!\""                               >> "action.sh"
        print "               motion -c /home/ubuntu/.motion/motion.conf"                   >> "action.sh"
        print "           fi"                                                               >> "action.sh"
        print "           STANDBY_COUNTER=$(($STANDBY_COUNTER+1)) "                         >> "action.sh"
        print "           if  [ $STANDBY_COUNTER -gt $UPDATE_DELAY ]; then"                 >> "action.sh"
        print "               STANDBY_COUNTER=1"                                            >> "action.sh"
        print "               sshpass -p $CAM_PSWD scp  $CAM_ID@se1rver.mailcam.co:/home/$CAM_ID/new_command.txt $EVENTCAM_DIR/"     >> "action.sh"
        print "               if diff new_command.txt prev_command.txt > /dev/null ; then"  >> "action.sh"
        print "                   echo \"Same cmd files.\""                                 >> "action.sh" 
        print "               else"                                                         >> "action.sh"
        print "                   echo \"New cmd file.\""                                   >> "action.sh" 
        print "                   break"                                                    >> "action.sh"
        print "               fi"                                                           >> "action.sh"
        print "           fi"                                                               >> "action.sh"
        print "           sleep 1"                                                          >> "action.sh"
        print "       fi"                                                                   >> "action.sh"
        print "done"                                                                        >> "action.sh"

        print "pid=$(head /home/ubuntu/.motion/motion.pid)"                                 >> "action.sh"
        print "echo \"Stop motion program!\""                                               >> "action.sh"
        print "kill -9 $pid"                                                                >> "action.sh"
        print "sleep 1"                                                                     >> "action.sh"
        print "rm -f $PIC_DIR/*"                                                            >> "action.sh"  

        print "if  [ $STANDBY_COUNTER -lt $UPDATE_DELAY ]; then"                            >> "action.sh"
        print "    rm -f movie_1.mp4 "                                                      >> "action.sh"
        print "    /home/ubuntu/bin/ffmpeg -f video4linux2 -i /dev/video0 -c:v libx264 -t "$19" -pix_fmt yuv420p -preset veryfast -tune fastdecode -profile:v baseline  -r 10 -me_range 4 -x264opts no-deblock movie_1.mp4 " >> "action.sh" 
        #print "    mpack -s video movie_1.mp4 "$11                                          >> "action.sh"
        print "    sshpass -p $CAM_PSWD scp $EVENTCAM_DIR/movie_1.mp4 $CAM_ID@se1rver.mailcam.co:/home/$CAM_ID/"                                                                                                                                               >> "action.sh"  
        print "    sshpass -p $CAM_PSWD ssh $CAM_ID@se1rver.mailcam.co 'mutt -s \"test mutt inel\" -a ~/movie_1.mp4 -- "$11" < ~/new_command.txt'"                                                                >> "action.sh"
        print "fi"                                                                           >> "action.sh"
    }
    else if ($7 == "Periodic")
    {
        print "#Periodic"                                                                   >> "action.sh"
        print "STANDBY_COUNTER=1"                                                           >> "action.sh"
        print "PERIOD_COUNTER=1"                                                            >> "action.sh"
        print "/home/ubuntu/bin/ffmpeg -f video4linux2 -s 320x240 -i /dev/video0 -c:v libx264 -t "$19" -pix_fmt yuv420p -preset veryfast -tune fastdecode -profile:v baseline  -r 10 -me_range 4 -x264opts no-deblock movie_1.mp4 " >> "action.sh" 
        #print "mpack -s video movie_1.mp4 "$11                                         >> "action.sh"
        print "sshpass -p $CAM_PSWD scp $EVENTCAM_DIR/movie_1.mp4 $CAM_ID@se1rver.mailcam.co:/home/$CAM_ID/"                                                                                        >> "action.sh"  
        print "sshpass -p $CAM_PSWD ssh $CAM_ID@se1rver.mailcam.co 'mutt -s \"test mutt inel\" -a ~/movie_1.mp4 -- "$11" < ~/new_command.txt'"                                                                        >> "action.sh"

        print "while true; do"                                                          >> "action.sh"
        print "    PERIOD_COUNTER=$(($PERIOD_COUNTER+1)) "                              >> "action.sh"
        print "    if  [ $PERIOD_COUNTER -gt $PERIOD ]; then"                           >> "action.sh"
        print "        break"                                                           >> "action.sh"
        print "    fi"                                                                  >> "action.sh"
        print "    STANDBY_COUNTER=$(($STANDBY_COUNTER+1)) "                            >> "action.sh"
        print "    if  [ $STANDBY_COUNTER -gt $UPDATE_DELAY ]; then"                    >> "action.sh"
        print "        STANDBY_COUNTER=1"                                               >> "action.sh"
        print "        sshpass -p $CAM_PSWD scp  $CAM_ID@se1rver.mailcam.co:/home/$CAM_ID/new_command.txt $EVENTCAM_DIR/"     >> "action.sh"
        print "        if diff new_command.txt prev_command.txt > /dev/null ; then"     >> "action.sh"
        print "            echo \"Same info files.\""                                   >> "action.sh" 
        print "        else"                                                            >> "action.sh"
        print "            echo \"New cmd file.\""                                      >> "action.sh" 
        print "            break"                                                       >> "action.sh"
        print "        fi"                                                              >> "action.sh"
        print "    fi"                                                                  >> "action.sh"
        print "    sleep 1"                                                             >> "action.sh"
        print "done"                                                                    >> "action.sh"
    }
    else if ($7 == "Still")
    {
        print "#Still"                                                                   >> "action.sh"
        print "DELAY_COUNTER=1"                                                          >> "action.sh"
        print "DELAY="$17                                                                >> "action.sh"
        print "PERIOD_COUNTER=1"                                                         >> "action.sh"
        print "INCREMENT_TIME=1"                                                         >> "action.sh"
        print "PIC_DIR=\"/home/ubuntu/.motion/test\" "                                   >> "action.sh"
        print "STANDBY_COUNTER=1"                                                        >> "action.sh"
        print "motion -c /home/ubuntu/.motion/motion.conf"                               >> "action.sh"
        print "sleep $INCREMENT_TIME"                                                    >> "action.sh"
        print "while true; do"                                                           >> "action.sh"
        print "    sleep $INCREMENT_TIME"                                                >> "action.sh"
        print "    if [ \"$(ls -A $PIC_DIR)\" ]; then"                                   >> "action.sh"
        print "        echo \"Motion detected!\""                                        >> "action.sh"
        print "        rm -f $PIC_DIR/*"                                                 >> "action.sh"
        print "        DELAY_COUNTER=1"                                                  >> "action.sh"
        print "        PERIOD_COUNTER=$(($PERIOD_COUNTER+$INCREMENT_TIME)) "             >> "action.sh"
        print "        if  [ $PERIOD_COUNTER -gt $PERIOD ]; then"                        >> "action.sh"
        print "            PERIOD_COUNTER=1"                                             >> "action.sh"
        print "            pid=$(head /home/ubuntu/.motion/motion.pid)"                  >> "action.sh"
        print "            echo \"Stop motion program!\""                                >> "action.sh"
        print "            kill -9 $pid"                                                 >> "action.sh"
        print "            sleep 1"                                                      >> "action.sh"
        print "            rm -f movie_1.mp4 "                                           >> "action.sh"
        print "            /home/ubuntu/bin/ffmpeg -f video4linux2 -i /dev/video0 -c:v libx264 -t $HBMOVIE_DURATION -pix_fmt yuv420p -preset veryfast -tune fastdecode -profile:v baseline  -r 10 -me_range 4 -x264opts no-deblock movie_1.mp4 " >> "action.sh" 
        print "            sshpass -p $CAM_PSWD scp $EVENTCAM_DIR/movie_1.mp4 $CAM_ID@se1rver.mailcam.co:/home/$CAM_ID/"                                                                                      >> "action.sh"  
        print "            sshpass -p $CAM_PSWD ssh $CAM_ID@se1rver.mailcam.co 'mutt -s \"test mutt inel\" -a ~/movie_1.mp4 -- "$11" < ~/new_command.txt'"                                                    >> "action.sh"
        print "            echo \"Start motion program!\""                               >> "action.sh"
        print "            motion -c /home/ubuntu/.motion/motion.conf"                   >> "action.sh"
        print "        fi"                                                               >> "action.sh"
        print "        STANDBY_COUNTER=$(($STANDBY_COUNTER+$INCREMENT_TIME)) "           >> "action.sh"
        print "        if  [ $STANDBY_COUNTER -gt $UPDATE_DELAY ]; then"                 >> "action.sh"
        print "            STANDBY_COUNTER=1"                                            >> "action.sh"
        print "            sshpass -p $CAM_PSWD scp  $CAM_ID@se1rver.mailcam.co:/home/$CAM_ID/new_command.txt $EVENTCAM_DIR/"     >> "action.sh"
        print "            if diff new_command.txt prev_command.txt > /dev/null ; then"  >> "action.sh"
        print "                echo \"Same info files.\""                                >> "action.sh" 
        print "            else"                                                         >> "action.sh"
        print "                echo \"New cmd file.\""                                   >> "action.sh" 
        print "                pid=$(head /home/ubuntu/.motion/motion.pid)"              >> "action.sh"
        print "                echo \"Stop motion program!\""                            >> "action.sh"
        print "                kill -9 $pid"                                             >> "action.sh"
        print "                sleep 1"                                                  >> "action.sh"
        print "                break"                                                    >> "action.sh"
        print "            fi"                                                           >> "action.sh"
        print "        fi"                                                               >> "action.sh"
        print "    else"                                                                 >> "action.sh"
        print "        echo \"WARNING! No motion detected.\""                            >> "action.sh"
        print "        DELAY_COUNTER=$(($DELAY_COUNTER+$INCREMENT_TIME)) "               >> "action.sh"
        print "        if  [ $DELAY_COUNTER -gt $DELAY ]; then"                          >> "action.sh"
        print "            STANDBY_COUNTER=1"                                            >> "action.sh"
        print "            pid=$(head /home/ubuntu/.motion/motion.pid)"                  >> "action.sh"
        print "            echo \"Stop motion program!\""                                >> "action.sh"
        print "            kill -9 $pid"                                                 >> "action.sh"
        print "            sleep 1"                                                      >> "action.sh"
        print "            rm -f movie_1.mp4 "                                           >> "action.sh"
        print "            /home/ubuntu/bin/ffmpeg -f video4linux2 -s 320x240 -i /dev/video0 -c:v libx264 -t "$19" -pix_fmt yuv420p -preset veryfast -tune fastdecode -profile:v baseline  -r 10 -me_range 4 -x264opts no-deblock movie_1.mp4 "            >> "action.sh" 
        #print "            mpack -s video movie_1.mp4 "$11                               >> "action.sh"
        print "sshpass -p $CAM_PSWD scp $EVENTCAM_DIR/movie_1.mp4 $CAM_ID@se1rver.mailcam.co:/home/$CAM_ID/"                                                                                        >> "action.sh"  
        print "sshpass -p $CAM_PSWD ssh $CAM_ID@se1rver.mailcam.co 'mutt -s \"test mutt inel\" -a ~/movie_1.mp4 -- "$11" < ~/new_command.txt'"                                                                                                             >> "action.sh"
        print "            break"                                                        >> "action.sh"
        print "        fi"                                                               >> "action.sh"
        print "    fi"                                                                   >> "action.sh"
        print "done"                                                                     >> "action.sh"
    }
}
