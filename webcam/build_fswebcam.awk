
BEGIN { FS = ":" } ; 
{ 
    print "#!/bin/bash -x" >> "final_loop.sh"
    print "#bibi Name " $2  " CamId " $4 " SpeedFactor " $6 " MovieDuration "  $8 " VideoRecording " $10  >> "final_loop.sh"
    print "rm -f movie_1.mp4" >> "final_loop.sh"
    
    print "rm -f user_name.txt" >> "final_loop.sh"
    print "echo "$2" > user_name.txt" >> "final_loop.sh"
    print "user=\"\$(sed -e \"s/ /_/g\" < user_name.txt)\"" >> "final_loop.sh"
    print "echo \$user " >> "final_loop.sh"
    print "if [\$user != \$USER_NAME ]; then" >> "final_loop.sh"
    print "    exit 1;" >> "final_loop.sh"
    print "fi" >> "final_loop.sh"
    print "if [ '"$10"' != 'Start' ]; then" >> "final_loop.sh"
    print "    exit 1;" >> "final_loop.sh"
    print "fi" >> "final_loop.sh"
    print "if [ "$4" != \$CAM_ID ]; then" >> "final_loop.sh"
    print "    exit 1;" >> "final_loop.sh"
    print "fi" >> "final_loop.sh"

    print "ffmpeg -f video4linux2 -input_format mjpeg -s 320x240  -vf \"setpts=(1/"$4")*PTS\" -i /dev/video0 movie_1.mp4 &" >> "final_loop.sh" 
    print "pid=$!" >> "final_loop.sh"
    print "sleep " $8*60 >> "final_loop.sh"    
    print "kill -SIGINT $pid" >> "final_loop.sh"
    print "sleep 1" >> "final_loop.sh"    
    print "kill -9 $pid" >> "final_loop.sh"
}
