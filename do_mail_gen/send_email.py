#!/usr/bin/python

"""
This program parses all home directories and sends email with the attachement being the jpg or mp4 files. The email address is extracted form the file new_command.txt. Once the email is sent the jpg , mp4 and txt files are deleted.
The directories names are read from a file named username.txt
"""
import fileinput
import os
import time
import filecmp
import logging


def save_size_of_files_sent(size_video_files_, email_user_name_):
    dir_user_statistics = "/home/" + email_user_name_
    file_with_sent_file_size = dir_user_statistics + "/sent_file_size.txt"
    print "bingo = " , file_with_sent_file_size
    if os.path.isfile(file_with_sent_file_size):
        f = open(file_with_sent_file_size)
        size_lines = f.readlines()
        f.close()
        print "size_lines = " , size_lines
        if len(size_lines) > 0:
            size_of_files_sent = size_lines[0].rstrip('\n')
            size_video_files_ += int(size_of_files_sent)
            os.remove(file_with_sent_file_size)
    
    f = open(file_with_sent_file_size, "w+")
    f.write(str(size_video_files_))
    f.close()


def compute_dir_size(dir_name):
    folder_size = 0
    for (path, dirs, files) in os.walk(dir_name):
        for file in files:
            filename = os.path.join(path, file)
            folder_size += os.path.getsize(filename)
    return folder_size


def main():
    f = open('username.txt')
    user_lines = f.readlines()
    f.close()
    
    EMAIL_LINE = 1
    LAST_LINE = 7
    LAST_LINE_PATTERN = "======="
    
    while 1:
        current_time = time.strftime("%Y-%m-%d %H:%M:%S")
        for user_line in user_lines:
            user_name = user_line.rstrip('\n')
            email_user_name = user_name + "on"
            dir2check = "/home/" + user_name
            dir2email = "/home/" + email_user_name
    
            file2check = dir2check + "/new_command.txt"
            file2check4email = dir2email + "/new_command.txt"
    
            if os.path.isfile(file2check) and (os.path.getsize(file2check) > 100):
                f = open(file2check)
                f2c_lines = f.readlines()
                f.close()
                if LAST_LINE_PATTERN not in f2c_lines[len(f2c_lines) - 1]:
                    continue
    
                cmd = 'rm -f ' + dir2check + '/read_finished.txt'
                print "cmd = ", cmd
                os.system(cmd)
    
                email = f2c_lines[EMAIL_LINE].split(" ")[2].rstrip('\n')
                video_files = os.listdir(dir2check)
                video_files.sort()
                size_video_files = 0
                for fname in video_files:
                    if fname.endswith(".jpg"):
                         full_fname_jpg = dir2check + '/' + fname
                         size_video_files += os.path.getsize(full_fname_jpg)
                         cmd = 'mv ' + full_fname_jpg + ' ' + dir2email
                         print "cmd = ", cmd
                         os.system(cmd)
                         cmd = 'mv ' + file2check + ' ' + dir2email
                         print "cmd = ", cmd
                         os.system(cmd)
                         full_fname_email_jpg = dir2email + '/' + fname
                         cmd = 'su ' + email_user_name + ' -c \"mutt -s \\"mailcam ' + current_time + '\\" -a ' + full_fname_email_jpg + ' -- ' + email + ' < ' + file2check4email + '\"'
                         print "cmd = ", cmd
                         os.system(cmd)
                         os.remove(full_fname_email_jpg)
                for fname in video_files:
                    if fname.endswith(".mp4"):
                         full_fname_mp4 = dir2check + '/' + fname
                         size_video_files += os.path.getsize(full_fname_mp4)
                         cmd = 'mv ' + full_fname_mp4 + ' ' + dir2email
                         print "cmd = ", cmd
                         os.system(cmd)
                         cmd = 'mv ' + file2check + ' ' + dir2email
                         print "cmd = ", cmd
                         os.system(cmd)
                         full_fname_email_mp4 = dir2email + '/' + fname
                         cmd = 'su ' + email_user_name + ' -c \"mutt -s \\"mailcam ' + current_time + '\\" -a ' + full_fname_email_mp4 + ' -- ' + email + ' < ' + file2check4email + '\"'
                         print "cmd = ", cmd
                         os.system(cmd)
                         os.remove(full_fname_email_mp4)
                # size in Kb
                size_video_files >>= 10
                print "Size in KB = " , size_video_files
                # remove the sent file created by email
                files_sent = dir2email + "/sent"
                if os.path.isfile(files_sent):
                    os.remove(files_sent)
    
                save_size_of_files_sent(size_video_files, email_user_name)
    
                mail_dir = dir2email + "/Maildir"
                if os.path.isdir(mail_dir):
                    mail_dir_size = compute_dir_size(mail_dir)
                    print "MailDir size is = " , mail_dir_size
                    if mail_dir_size > 10000:
                         cmd = 'su ' + user_name + ' -c \"mutt -s \\"mailcam wrong email from user ' + current_time + '\\"  -- cicerone.mihalache@gmail.com < ' + file2check + '\"'
                         os.system(cmd)
                         cmd = "rm -rf " + mail_dir
                         os.system(cmd)
                         print "Maildir is removed"
                         
                        
                # remove the new_command.txt
                if os.path.isfile(file2check):
                    if os.path.isfile(file2check4email):
                        cmd = 'touch ' + file2check4email
                        print "cmd = ", cmd
                        os.system(cmd)
                   
                    if not filecmp.cmp(file2check, file2check4email):
                        cmd = 'mv ' + file2check + ' ' + dir2email
                        print "cmd = ", cmd
                        os.system(cmd)
                        cmd = 'su ' + email_user_name + ' -c \"mutt -s \\"mailcam ' + current_time + '\\" -- ' + email + ' < ' + file2check4email + '\"'
                        print "cmd = ", cmd
                        os.system(cmd)
    
                if os.path.isfile(file2check):
                    os.remove(file2check)
    
                cmd = 'touch ' + dir2check + '/read_finished.txt'
                print "cmd = ", cmd
                os.system(cmd)


logging.basicConfig(level=logging.DEBUG, filename='/home/wrylvoin/send_email_err.log')

try:
    main()
except:
    logging.exception('Error')

