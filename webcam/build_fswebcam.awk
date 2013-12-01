
BEGIN { FS = ":" } ; 
{ 
    print "#!/bin/bash -x" >> "final_loop.sh"
    print "#bibi Email " $2  " CamId " $4 " Password " $6 "SpeedFactor " $8 " MovieDuration "  $10 " VideoRecording " $12  >> "final_loop.sh"
    print "rm -f movie_1.mp4" >> "final_loop.sh"
    
    print "if [ '"$12"' != 'Start' ]; then" >> "final_loop.sh"
    print "    exit 1;" >> "final_loop.sh"
    print "fi" >> "final_loop.sh"
    print "if [ "$4" != $CAM_ID ]; then" >> "final_loop.sh"
    print "    exit 1;" >> "final_loop.sh"
    print "fi" >> "final_loop.sh"
    print "if ['"$6"' != $CAMUSER_PSWD ]; then" >> "final_loop.sh"
    print "    exit 1;" >> "final_loop.sh"
    print "fi" >> "final_loop.sh"

    print "ffmpeg -f video4linux2 -input_format mjpeg -s 320x240  -vf \"setpts=(1/"$4")*PTS\" -i /dev/video0 movie_1.mp4 &" >> "final_loop.sh" 
    print "pid=$!" >> "final_loop.sh"
    print "sleep " $8*60 >> "final_loop.sh"    
    print "kill -SIGINT $pid" >> "final_loop.sh"
    print "sleep 1" >> "final_loop.sh"    
    print "kill -9 $pid" >> "final_loop.sh"
}
