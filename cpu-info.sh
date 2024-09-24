#!/bin/bash

SOCKET=`lscpu |grep -w "Socket(s):"|  awk '{print $2}'`
CPSOCKET=`lscpu |grep -w "Core(s) per socket:"|  awk '{print $4}'`
THREAD=`lscpu |grep -w "Thread(s) per core:" | awk '{print $4}'`
CPUMHz=`lscpu |grep -w "CPU MHz:" | awk '{print $3}'`

TCORE=$(($SOCKET * $CPSOCKET))
TTHREAD=$(($TCORE * $THREAD))

echo CPU Speed=$CPUMHz
echo Total Socket=$SOCKET
echo Total Core=$TCORE
echo Total Thread=$TTHREAD