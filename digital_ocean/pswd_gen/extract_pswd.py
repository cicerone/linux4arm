#!/usr/bin/python
"""
This program has two arguments, the user name and the password (each of 8 chars). 
It inserts in the last line of the serial_nr.jpg file the above strings at starting at postion 3 and 17.
"""

import fileinput


jpeg_file = open("serial_nr.jpg", "r")
lines = jpeg_file.readlines()
jpeg_file.close()
nr_lines = len(lines)
last_line = lines[nr_lines - 1]
print len(last_line)

username = last_line[3:11] 
password = last_line[15:23] 
print username
print password



