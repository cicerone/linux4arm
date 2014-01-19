#!/usr/bin/python
"""
This program takes two inputs, email.log and password.txt and generates another file named 
commands.log.
"""
import fileinput


f = open('email.log')
email_lines = f.readlines()
f.close()
f = open('password.txt')
password_lines = f.readlines()
f.close()

EMAIL_ID_INDEX = 2
EMAIL_PSWD_INDEX = 4
PSWD_ID_INDEX = 0
PSWD_PSWD_INDEX = 1

f = open("commands.log", "w")
for email_line in email_lines:
#    print "line number %d", i, email_lines[i]
    email_fields = email_line.split(":")
    print "email_field 3 and 5", email_fields[EMAIL_ID_INDEX], email_fields[EMAIL_PSWD_INDEX]
    for password_line in password_lines:
        password_fields = password_line.split(":")
        print "password_field 0 and 1", password_fields[PSWD_ID_INDEX], password_fields[PSWD_PSWD_INDEX]
        if email_fields[EMAIL_ID_INDEX] == password_fields[PSWD_ID_INDEX] and email_fields[EMAIL_PSWD_INDEX] == password_fields[PSWD_PSWD_INDEX]:
            f.write(email_line)
            print "BINGO"
            break

f.close()

