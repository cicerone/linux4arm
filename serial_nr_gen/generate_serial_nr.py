#!/usr/bin/python
"""
This program takes two inputs, user_pswd.txt and image.txt,  and generates   set of serial_nr.jpg files, one per user.
The files are placed one per directory, the directory having the name of the user.
"""


import fileinput
import os
import shutil 

# !!! Manually change this server name !!!
#server_name = 'unalutus'
server_name = 'unalutus'


f = open('user_pswd.txt')
up_lines = f.readlines()
f.close()

USER_INDEX = 0
PSWD_INDEX = 1

for up_line in up_lines:
    fields = up_line.split(":")
    #print "field 0 and 1", fields[USER_INDEX], fields[PSWD_INDEX]
    dir2copy = "sn_container_" + server_name + "/" + fields[USER_INDEX] 
    if os.path.isdir(dir2copy) == False:
        os.makedirs(dir2copy)

    serial_nr_file_name = dir2copy + "/serial_nr.txt"
    serial_nr_file = open(serial_nr_file_name, "w") 
    new_line = fields[USER_INDEX] + fields[PSWD_INDEX] + server_name
    serial_nr_file.write(new_line)
    serial_nr_file.close()


