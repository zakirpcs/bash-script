#!/bin/bash

#----------------------------------
# Name: Trace Log Transfer Script -
# Developer: Md. Zakir Hossain    -
# Mail: zakirpcs@gmail.com        -
# Version: 1.0                    -
# Release Date: 19-11-2017        -
#----------------------------------

_USER="two"
_RHOST="10.10.11.39"
_RDIR="/two-log/TWO01"

cd /transaction_logs
_FIND=`find . -type f -name '*.prev'`

for _FILE in  $_FIND

do
	_FILE_PATH="/compass/TWO/TRACE/ATM"
	_BANK_NAME=`echo $_FILE|cut -d "." -f 2|cut -d "/" -f 2`
	_BASE_NAME=`basename $_FILE`
	_FILE_NAME=`echo $_BASE_NAME| awk -F . '{print $1"."$2}'`
	_FILE_EXT=`echo $_FILE | awk -F . '{print $NF}'`
	
	#Check bank name is exists in destination directory
	scp -rp $_FILE_PATH/$_BANK_NAME/$_FILE_NAME.$_FILE_EXT $_USER@$_RHOST:$_RDIR/$_BANK_NAME/$_FILE_NAME.$_FILE_EXT
	
	#After copy then delete
	rm -f $_FILE_PATH/$_BANK_NAME/$_FILE_NAME.$_FILE_EXT
done
