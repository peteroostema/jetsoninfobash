#!/bin/bash

while [ "true" ]
do
   sudo bash /home2/peter/Documents/sysInfo/systemInfov2.sh
#   rsh peter@headNode "sudo bash /home2/peter/Documents/sysInfo/systemInfov2.sh"
#   echo hn
#   cat /etc/hostname
#   echo "$(cat /home2/peter/Documents/sysInfo/sysInfo.txt)"
#   rsh peter@worker01 "sudo bash /home2/peter/Documents/sysInfo/systemInfov2.sh"
#   echo w02
#   cat /etc/hostname
#   echo "$(cat /home2/peter/Documents/sysInfo/sysInfo.txt)"
#   rsh peter@worker02 "sudo bash /home2/peter/Documents/sysInfo/systemInfov2.sh"
#   echo w02
#   cat /etc/hostname
#   echo "$(cat /home2/peter/Documents/sysInfo/sysInfo.txt)"
   headstats="$(cat /home2/peter/Documents/sysInfo/sysInfoheadNode.txt)"
   wk01stats="$(cat /home2/peter/Documents/sysInfo/sysInfoworker01.txt)"
   wk02stats="$(cat /home2/peter/Documents/sysInfo/sysInfoworker02.txt)"
   fullstats="hdnd,"$headstats",wk01,"$wk01stats",wk02,"$wk02stats
   echo $fullstats > /home2/peter/Documents/sysInfo/sysInfo.txt
sleep 2
done
