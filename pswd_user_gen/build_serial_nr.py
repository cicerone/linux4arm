#!/usr/bin/python
"""
This program takes two inputs, user_pswd.txt and image.txt,  and generates   set of serial_nr.jpg files, one per user.
The files are placed one per directory, the directory having the name of the user.
"""


import fileinput
import os
import shutil 



jpeg_file = open("image.jpg", "r")
jpg_lines = jpeg_file.readlines()
jpeg_file.close()
nr_jpg_lines = len(jpg_lines)
last_jpg_line = jpg_lines[nr_jpg_lines - 1]


f = open('user_pswd.txt')
up_lines = f.readlines()
f.close()

USER_INDEX = 0
PSWD_INDEX = 1

for up_line in up_lines:
    fields = up_line.split(":")
    #print "field 0 and 1", fields[USER_INDEX], fields[PSWD_INDEX]
    dir2copy = "sn_container/" + fields[USER_INDEX] 
    if os.path.isdir(dir2copy) == False:
        os.makedirs(dir2copy)

    serial_nr_file_name = dir2copy + "/serial_nr.jpg"
    serial_nr_file = open(serial_nr_file_name, "w") 
    new_line = last_jpg_line[:3] + fields[USER_INDEX] + last_jpg_line[11:15] + fields[PSWD_INDEX] + last_jpg_line[31:]
    cntr = 0
    for jpg_line in jpg_lines:
        if cntr == nr_jpg_lines - 1:
            serial_nr_file.write(new_line)
        else:
            serial_nr_file.write(jpg_line)
        cntr += 1
    serial_nr_file.close()


