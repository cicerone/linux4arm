#!/usr/bin/python
"""
This program takes two inputs, email.log and password.txt and generates another file named 
email_checked.log.
"""
import fileinput
import os
import shutil 

f = open('commands.log')
cmd_lines = f.readlines()
f.close()

USER_NAME_ID  = 2
MODE_ID       = 6
PIC_NR_ID     = 14
DELAY_ID      = 16
MOVIE_TIME_ID = 18
HEART_BEAT_ID = 22
ACTION_ID     = 26

for cmd_line in cmd_lines:
#    print "line number %d", i, email_lines[i]
    cmd_fields = cmd_line.split(":")
   # print "cmd field 3 and 5", cmd_fields[USER_NAME_ID], email_fields[EMAIL_PSWD_INDEX]
    dir2copy = "/home/"
    dir2copy += cmd_fields[USER_NAME_ID]
    if os.path.isdir(dir2copy) == False:
        os.makedirs(dir2copy)

    print "directory to copy files = ", dir2copy
    file2remove = dir2copy + "/info.log"
    print "file to remove = ", file2remove 
    f = open('info.log', "w")
    f.write(cmd_line)
    f.close();
    if os.path.isfile(file2remove):
        os.remove(file2remove)
    shutil.move("info.log", dir2copy)

    f = open('new_command.txt', "w")
    seen_cmd = "Mode = " + cmd_fields[MODE_ID] 
    seen_cmd = seen_cmd + "\nPictures Nr = " + cmd_fields[PIC_NR_ID] 
    seen_cmd = seen_cmd +  "\nDelay = " + cmd_fields[DELAY_ID]
    seen_cmd = seen_cmd +  "\nMovie Duration = " + cmd_fields[MOVIE_TIME_ID]
    seen_cmd = seen_cmd +  "\nHeartBeat = " + cmd_fields[HEART_BEAT_ID]
    seen_cmd = seen_cmd +  "\nAction = " + cmd_fields[ACTION_ID]
    f.write(seen_cmd)
    f.close()
    shutil.move("new_command.txt", dir2copy)


