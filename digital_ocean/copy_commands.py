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

EMAIL_ID_INDEX = 3
EMAIL_PSWD_INDEX = 5

for cmd_line in cmd_lines:
#    print "line number %d", i, email_lines[i]
    cmd_fields = cmd_line.split(":")
   # print "cmd field 3 and 5", cmd_fields[EMAIL_ID_INDEX], email_fields[EMAIL_PSWD_INDEX]
    dir2copy = "/var/www/mail_cam/d"
    dir2copy += cmd_fields[EMAIL_ID_INDEX]
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


