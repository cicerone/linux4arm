#!/usr/bin/python
"""
This program takes two inputs, email.log and password.txt and generates another file named 
email_checked.log.
"""
import fileinput
import os
import shutil 
import logging


def main():
    f = open('commands.log')
    cmd_lines = f.readlines()
    f.close()
    
    USER_NAME_ID  = 2
    MODE_ID       = 6
    EMAIL_ID      = 10
    PIC_NR_ID     = 14
    DELAY_ID      = 16
    MOVIE_TIME_ID = 18
    HEART_BEAT_ID = 22
    RESOLUTION_ID = 24
    ACTION_ID     = 26
    
    for cmd_line in cmd_lines:
        cmd_fields = cmd_line.split(":")
       # print "cmd field 3 and 5", cmd_fields[USER_NAME_ID], email_fields[EMAIL_PSWD_INDEX]
        dir2copy = "/home/"
        dir2copy += cmd_fields[USER_NAME_ID]
        if os.path.isdir(dir2copy) == False:
            os.makedirs(dir2copy)
     
        #print "directory to copy files = ", dir2copy
        f = open('info.log', "w")
        f.write(cmd_line)
        f.close();
        
        if os.path.isfile("info.log"):
            awk_cmd = "awk -f ./build_action.awk ./info.log; chmod 744 action.sh;"
            os.system(awk_cmd)
            file2remove = dir2copy + "/action.sh"
            if os.path.isfile(file2remove):
                os.remove(file2remove)
            shutil.move("action.sh", dir2copy)
        
     
        f = open('new_command.txt', "w")
        seen_cmd = "Mode = " + cmd_fields[MODE_ID] 
        seen_cmd = seen_cmd + "\nEmail = " + cmd_fields[EMAIL_ID] 
        seen_cmd = seen_cmd + "\nPictures Nr = " + cmd_fields[PIC_NR_ID] 
        seen_cmd = seen_cmd + "\nDelay = " + cmd_fields[DELAY_ID] + " s"
        seen_cmd = seen_cmd + "\nMovie Duration = " + cmd_fields[MOVIE_TIME_ID] + " s"
        seen_cmd = seen_cmd + "\nHeartBeat = " + cmd_fields[HEART_BEAT_ID] + " m"
        seen_cmd = seen_cmd + "\nResolution = " + cmd_fields[RESOLUTION_ID]
        seen_cmd = seen_cmd + "\nAction = " + cmd_fields[ACTION_ID]
        seen_cmd = seen_cmd + "\n======="
        f.write(seen_cmd)
        f.close()
        file2remove = dir2copy + "/new_command.txt"
        if os.path.isfile(file2remove):
            os.remove(file2remove)
        shutil.move("new_command.txt", dir2copy)


logging.basicConfig(level=logging.DEBUG, filename='/home/cabsibia/copy_commands_err.log')

try:
    main()
except:
    logging.exception('Error')

