#!/bin/bash
#-------------------------------------
# Name: SFTP User add		     -
# Developer: Md. Zakir Hossain       -
# Mail: zakirpcs@gmail.com           -
# Version: 1.1                       -
# Release Date: 31-01-2022           -
#-------------------------------------
# Script to add a user to Linux system

if [ $(id -u) -eq 0 ]; then
	read -p "Enter username : " username
	read -s -p "Enter password : " password
	egrep "^$username" /etc/passwd >/dev/null
	if [ $? -eq 0 ]; then
		echo "$username exists!"
		exit 1
	else
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		
		useradd -G sftp,systems -d /home/sftp/$username -p $pass $username
		
		ID=`id $username | awk '{print $1}'| cut -d "=" -f2| cut -d "(" -f1`
		chown root:root /home/sftp/$username
		chmod 755 /home/sftp/$username
		cd /home/sftp/$username
		mkdir home$username
		chown $username:$username home$username
		chown $username:systems home$username
		usermod -d /home$username $username
		
		#sed -i 's/$username:x:$ID:/$username:x:$ID:$username,systems/g' /etc/group

		[ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
	fi
else
	echo "Only root may add a user to the system"
	exit 2
fi
