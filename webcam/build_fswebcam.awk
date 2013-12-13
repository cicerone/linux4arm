
BEGIN { FS = ":" } ; 
{ 
    print "#!/bin/bash -x" >> "final_loop.sh"
    print "#bibi Email " $2  " CamId " $4 " Password " $6 " SpeedFactor " $8 " MovieDuration "  $10 " VideoRecording " $12  >> "final_loop.sh"
    print "rm -f email_addr.txt" >> "final_loop.sh"
    print "echo "$2" > email_addr.txt"  >> "final_loop.sh"
    print "if [ '"$12"' != 'Start' ]; then" >> "final_loop.sh"
    print "    exit 1;" >> "final_loop.sh"
    print "fi" >> "final_loop.sh"
    print "if [ "$4" != $CAM_ID ]; then" >> "final_loop.sh"
    print "    exit 1;" >> "final_loop.sh"
    print "fi" >> "final_loop.sh"
    print "if ['"$6"' != $CAM_PSWD ]; then" >> "final_loop.sh"
    print "    exit 1;" >> "final_loop.sh"
    print "fi" >> "final_loop.sh"
    #print "ffmpeg -f video4linux2 -input_format mjpeg -s 320x240  -vf \"setpts=(1/"$8")*PTS\" -i /dev/video0 movie_1.mp4 " >> "final_loop.sh" 
    #0print "ffmpeg -f video4linux2 -i /dev/video0 -c:v libx264 -pix_fmt yuv420p  -r 10 -t "$10" -bf 1 -subq 3 -bufsize 100000000 -maxrate 100000 movie_1.mp4 " >> "final_loop.sh" 
    #print "/home/ubuntu/bin/ffmpeg -report -f video4linux2 -i /dev/video0 -c:v libx264 -t "$10" -pix_fmt yuv420p -preset ultrafast -profile:v baseline  -r 10 -tune film movie_1.mp4 " >> "final_loop.sh" 


    #GOOD print "/home/ubuntu/bin/ffmpeg -f video4linux2 -i /dev/video0 -c:v libx264 -t "$10" -pix_fmt yuv420p -preset superfast -profile:v baseline  -r 10 -me_range 4 -x264opts no-deblock movie_1.mp4 " >> "final_loop.sh" 
    print "/home/ubuntu/bin/ffmpeg -f video4linux2 -i /dev/video0 -c:v libx264 -t "$10" -pix_fmt yuv420p -preset veryfast -tune fastdecode -profile:v baseline  -r 10 -me_range 4 -x264opts no-deblock movie_1.mp4 " >> "final_loop.sh" 
#    print "mpack -s video movie_1.mp4 "$2 >> "final_loop.sh"
}
