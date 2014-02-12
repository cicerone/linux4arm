#!/usr/bin/python
"""
This program takes one input, user_pswd.txt,  and generates Linux users with the name
and password as specified in the user_pswd.txt file. 
"""

import fileinput
import os
import shutil 


f = open('user_pswd.txt')
up_lines = f.readlines()
f.close()

USER_INDEX = 0
PSWD_INDEX = 1

for up_line in up_lines:
    fields = up_line.split(":")
    #print "field 0 and 1", fields[USER_INDEX], fields[PSWD_INDEX]
    cmd = '/usr/sbin/useradd -d \"/home/' + fields[USER_INDEX] + '\" -s /bin/bash -m \"' + fields[USER_INDEX] + '\"'
    print "cmd = ", cmd
    os.system(cmd)
    cmd = 'echo \"' + fields[USER_INDEX] + ':' + fields[PSWD_INDEX] + '\" | chpasswd'
    print "cmd = ", cmd
    os.system(cmd)
    cmd = '/bin/chmod 300 /home/' + fields[USER_INDEX]
    print "cmd = ", cmd
    os.system(cmd)
    cmd = '/bin/chmod 400 /home/' + fields[USER_INDEX] + '/.bashrc'
    print "cmd = ", cmd
    os.system(cmd)
    cmd = '/bin/chmod 400 /home/' + fields[USER_INDEX] + '/.profile'
    print "cmd = ", cmd
    os.system(cmd)
    cmd = '/bin/chmod 400 /home/' + fields[USER_INDEX] + '/.bash_logout'
    print "cmd = ", cmd
    os.system(cmd)
    cmd = '/usr/sbin/usermod -s /usr/bin/rssh ' + fields[USER_INDEX]
    print "cmd = ", cmd
    os.system(cmd)



