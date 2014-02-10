#!/usr/bin/python

"""
This program parses all home directories and sends email with the attachement being the jpg or mp4 files. The email address is extracted form the file new_command.txt. Once the email is sent the jpg , mp4 and txt files are deleted.
The directories names are read from a file named username.txt
"""
import fileinput
import os

f = open('username.txt')
user_lines = f.readlines()
f.close()

while 1:
    for user_line in user_lines:
        dir2check = "/home/"
        user_name = user_line.rstrip('\n')
        dir2check += user_name

        file2check = dir2check + "/new_command.txt"
        if os.path.isfile(file2check) and (os.path.getsize(file2check) > 100):
            f = open(file2check)
            f2c_lines = f.readlines()
            f.close()
            email = f2c_lines[1].split(" ")[2].rstrip('\n')
            video_files = os.listdir(dir2check)
            video_files.sort()
            for fname in video_files:
                if fname.endswith(".jpg"):
                     full_fname_jpg = dir2check + '/' + fname
                     cmd = 'su ' + user_name + ' -c \"mutt -s \\"mutt inel\\" -a ' + full_fname_jpg + ' -- ' + email + ' < ' + file2check + '\"'
                     print "cmd = ", cmd
                     os.system(cmd)
                     os.remove(full_fname_jpg)
            for fname in video_files:
                if fname.endswith(".mp4"):
                     full_fname_mp4 = dir2check + '/' + fname
                     cmd = 'su ' + user_name + ' -c \"mutt -s \\"mutt inel\\" -a ' + full_fname_mp4 + ' -- ' + email + ' < ' + file2check + '\"'
                     print "cmd = ", cmd
                     os.system(cmd)
                     os.remove(full_fname_mp4)

            # remove the new_command.txt
            os.remove(file2check)
            files_sent = dir2check + "/sent"
            
            if os.path.isfile(files_sent):
                os.remove(files_sent)




