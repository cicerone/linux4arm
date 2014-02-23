#!/bin/bash
#turn off leds   
cd /sys/class/leds/beaglebone\:green\:usr0
echo none > trigger
cd /sys/class/leds/beaglebone\:green\:usr1
echo none > trigger
cd /sys/class/leds/beaglebone\:green\:usr2
echo none > trigger
cd /sys/class/leds/beaglebone\:green\:usr3
echo none > trigger
cd ~
