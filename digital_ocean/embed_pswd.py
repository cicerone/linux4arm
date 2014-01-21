#!/usr/bin/python
"""
This program has two arguments, the user name and the password (each of 8 chars). 
It inserts in the last line of the serial_nr.jpg file the above strings at starting at postion 3 and 17.
"""

import fileinput


jpeg_file = open("star.jpg", "r")
lines = jpeg_file.readlines()
jpeg_file.close()
nr_lines = len(lines)
last_line = lines[nr_lines - 1]
print len(last_line)
print last_line

username = 'bbcdefgh'
password = '12345678'
new_line = last_line[:3] + username + last_line[11:15] + password + last_line[23:]
print len(new_line)
print new_line


jpeg_file = open("serial_nr.jpg", "w")
cntr = 0
for line in lines:
    if cntr == nr_lines - 1:
        jpeg_file.write(new_line)
    else:
        jpeg_file.write(line)
    cntr += 1
jpeg_file.close()

