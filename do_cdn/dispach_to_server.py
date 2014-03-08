#!/usr/bin/python
"""
This program takes two input files and produces one file called email.log that contain all the info needed by the camera.
From the id_passwd_path.log file takes the path to the jpg file that contain the passw and user name. These two fileds are appended to the line got from the partial_email.log file and then the email.log file is written.
"""
import fileinput
import os
import logging
from datetime import datetime


def main():
    f = open('server.txt')
    server_lines = f.readlines()
    f.close()

    f = open('partial_email.log')
    partial_email_lines = f.readlines()
    f.close()

    list_part_email_line = partial_email_lines[0].split('serialnr:')
#    print list_part_email_line

    serial_nr = list_part_email_line[1].split(':')
#    print serial_nr
    
    username   = serial_nr[0][0:8]
    password   = serial_nr[0][8:24]
    servername = serial_nr[0][24:32]
#   print username
#   print password
#   print servername

    
    f = open("email.log", "w")
    new_line = ':username:' + username + ':pswd:' + password  + ':' +  list_part_email_line[0] + 'servername:' + servername + ':last_word'
    f.write(new_line)
    f.close()
 
 
    is_valid_server = False
    for server_line in server_lines:
        server_supported = server_line.rstrip('\n')
        if servername == server_supported:
            #print "BINGO send email"
            # TODO change the se1rver with the server name and email.log with time based email name
            cmd = 'mutt -s \"new_cmd\"  -- cabsibia@cmd.' + servername + '.mailcam.co < email.log'
            #print cmd
            os.system(cmd)
            is_valid_server = True 
    
 
    if not is_valid_server:
        sender_ip_file_name = 'sender_ip.log_' + str(datetime.now().microsecond)
        cmd = 'mv sender_ip.log  /home/hizatcix/wrong_ip/' + sender_ip_file_name
        os.system(cmd)


logging.basicConfig(level=logging.DEBUG, filename='/home/hizatcix/err.log')

try:
    main()
except:
    logging.exception('Error')
                          
                           
                           
                           
