#!/usr/bin/python
"""
This program takes two input files and produces one file called email.log that contain all the info needed by the camera.
From the id_passwd_path.log file takes the path to the jpg file that contain the passw and user name. These two fileds are appended to the line got from the partial_email.log file and then the email.log file is written.
"""
import fileinput
import os


f = open('id_passwd_path.log')
id_passwd_path_lines = f.readlines()
f.close()

f = open('server.txt')
server_lines = f.readlines()
f.close()

start_http = 'href="'
end_http   = '">serial_nr.jpg'
jpg_path   = id_passwd_path_lines[0].split(start_http)[1].split(end_http)[0] 
cmd = 'wget ' + jpg_path 
os.system(cmd)
#print jpg_path

jpeg_file = open("serial_nr.jpg", "r")
jpeg_lines = jpeg_file.readlines()
jpeg_file.close()
nr_lines = len(jpeg_lines)
jpeg_last_line = jpeg_lines[nr_lines - 1]

username   = jpeg_last_line[3:11]
password   = jpeg_last_line[15:31]
servername = jpeg_last_line[31:39]

#print username
#print password
#print servername

f = open('partial_email.log')
partial_email_lines = f.readlines()
f.close()


f = open("email.log", "w")
new_line = ':username:' + username + ':pswd:' + password  + ':' +  partial_email_lines[0].rstrip('\n') + 'servername:' + servername
f.write(new_line)
f.close()


for server_line in server_lines:
    server_supported = server_line.rstrip('\n')
    if servername == server_supported:
        print "BINGO send email"
        # TODO change the se1rver with the server name and email.log with time based email name
        cmd = 'mutt -s \"new_cmd\"  -- suse465@se1rver.mailcam.co < email.log'
        os.system(cmd)

print "Done!"
    
