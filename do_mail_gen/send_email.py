#!/usr/bin/python

"""
This program parses all home directories and sends email with the attachement being the jpg or mp4 files. The email address is extracted form the file new_command.txt. Once the email is sent the jpg , mp4 and txt files are deleted.
The directories names are read from a file named username.txt
"""
import fileinput
import os


def save_size_of_files_sent(size_video_files_):
    dir_user_statistics = "/home/" + email_user_name
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


f = open('username.txt')
user_lines = f.readlines()
f.close()

while 1:
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
            email = f2c_lines[1].split(" ")[2].rstrip('\n')
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
                     cmd = 'cp -rf ' + file2check + ' ' + dir2email
                     print "cmd = ", cmd
                     os.system(cmd)
                     full_fname_email_jpg = dir2email + '/' + fname
                     cmd = 'su ' + email_user_name + ' -c \"mutt -s \\"mutt inel\\" -a ' + full_fname_email_jpg + ' -- ' + email + ' < ' + file2check4email + '\"'
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
                     cmd = 'cp -rf ' + file2check + ' ' + dir2email
                     print "cmd = ", cmd
                     os.system(cmd)
                     full_fname_email_mp4 = dir2email + '/' + fname
                     cmd = 'su ' + email_user_name + ' -c \"mutt -s \\"mutt inel\\" -a ' + full_fname_email_mp4 + ' -- ' + email + ' < ' + file2check4email + '\"'
                     print "cmd = ", cmd
                     os.system(cmd)
                     os.remove(full_fname_email_mp4)

            # size in Kb
            size_video_files >>= 10
            # remove the sent file created by email
            files_sent = dir2email + "/sent"
            if os.path.isfile(files_sent):
                os.remove(files_sent)

            save_size_of_files_sent(size_video_files)

            mail_dir = dir2email + "/Maildir"
            if os.path.isdir(mail_dir):
                mail_dir_size = compute_dir_size(mail_dir)
                print "MailDir size is = " , mail_dir_size
                if mail_dir_size > 10000:
                     cmd = 'su ' + user_name + ' -c \"mutt -s \\"mailcam wrong email from user\\"  -- cicerone.mihalache@gmail.com < ' + file2check + '\"'
                     os.system(cmd)
                     cmd = "rm -rf " + mail_dir
                     os.system(cmd)
                     print "Maildir is removed"
                     
                    
            # remove the new_command.txt
            os.remove(file2check)
            other_files = os.listdir(dir2check)
            print "Other files " , other_files
