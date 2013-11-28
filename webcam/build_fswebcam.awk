
BEGIN { FS = ":" } ; 
{ 
    print "#!/bin/bash -x" >> "final_loop.sh"
    print "#bibi VideoRecording " $2  " SlowFactor " $4 " SpeedFactor " $6 " MovieDuration "  $8 " Resolution " $10      >> "final_loop.sh"
    print "rm -f movie_1.mp4" >> "final_loop.sh"
    
    print "if [ '"$2"' != 'Start' ]; then" >> "final_loop.sh"
    print "    exit 1;" >> "final_loop.sh"
    print "fi" >> "final_loop.sh"

    print "ffmpeg -f video4linux2 -input_format mjpeg -s "$10"  -vf \"setpts=("$6"/"$4")*PTS\" -i /dev/video0 movie_1.mp4 &" >> "final_loop.sh" 
    print "pid=$!" >> "final_loop.sh"
    print "sleep " $8 >> "final_loop.sh"    
    print "kill -SIGINT $pid" >> "final_loop.sh"
    print "sleep 1" >> "final_loop.sh"    
    print "kill -9 $pid" >> "final_loop.sh"
}
