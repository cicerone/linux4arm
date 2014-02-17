#!/bin/bash -x

# Checks if you have the right privileges
#if [ "$USER" = "root" ]
if [ "$USER" = "root" ]
then

# CHANGE THIS PARAMETERS FOR A PARTICULAR USE
PERS_HOME="/home/"
PERS_SH="/usr/bin/rssh"

   # Checks if there is an argument
   [ $# -eq 0 ] && { echo >&2 ERROR: You may enter as an argument a text file containing users, one per line. ; exit 1; }
   # checks if there a regular file
   [ -f "$1" ] || { echo >&2 ERROR: The input file does not exists. ; exit 1; }
   TMPIN=$(mktemp)
   # Remove blank lines and delete duplicates 
   sed '/^$/d' "$1"| sort -g | uniq > "$TMPIN"

   #NOW=$(date +"%Y-%m-%d-%X")
   NOW=$(date +"%Y-%m-%d")
   LOGFILE="AMU-log-$NOW.log"

   for user in $(more "$TMPIN"); do
      # Checks if the user already exists.
      cut -d: -f1 /etc/passwd | grep "$user" > /dev/null
      OUT=$?
      if [ $OUT -eq 0 ];then
         echo >&2 "ERROR: User account: \"$user\" already exists."
         echo >&2 "ERROR: User account: \"$user\" already exists." >> "$LOGFILE"
      else
         # Create a new user
         #pass=$(/home/roni/user_generation/passwdgen-0.1.2/src/passwdgen)
         pass=$(passwdgen -m 8 -M 8)
         /usr/sbin/useradd -d "$PERS_HOME""$user" -s "$PERS_SH" -m "$user"
         #this does the trick to set the proper passwd
         echo "$user:$pass" | chpasswd
         chmod 500 $PERS_HOME"$user"
         echo -e $user":"$pass":" >> "$LOGFILE"
         echo "The user \"$user\" has been created and has the password: $pass"
      fi
   done
   rm -f "$TMPIN"
   exit 0
else
   echo >&2 "ERROR: You must be a root user to execute this script."
#   exit 1
fi
