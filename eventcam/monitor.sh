#!/bin/bash -x
PIC_DIR="/home/ubuntu/.motion/test"
COUNTER=1
while true; do
    motion -c /home/ubuntu/.motion/motion.conf
    while true; do
           if [ "$(ls -A $PIC_DIR)" ]; then
               echo "WARNING! Motion detected!"
               last_file=$(ls -t $PIC_DIR| tail -1)
               mpack -s picture $PIC_DIR/$last_file cicerone.mihalache@gmail.com
               echo "$PIC_DIR/$last_file"
               sleep 1
               rm -f $PIC_DIR/$last_file
               COUNTER=$(($COUNTER +1)) 
               if  [ $COUNTER -gt 5 ]; then
                   break
               fi
           else
               echo "No motion detected."
               sleep 1
           fi
           echo "Counter is " $COUNTER
    done
    pid=$(head /home/ubuntu/.motion/motion.pid)
    echo "Stop motion program!"
    kill -9 $pid
    rm -f $PIC_DIR/* 
    COUNTER=1
    sleep 10
done
