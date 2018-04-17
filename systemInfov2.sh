#!/bin/bash

#while [ "true" ]
#do


# usage of processors
cd /home/nvidia/
sudo ./tegrastats > /home2/peter/Documents/sysInfo/usage.txt &
cd /home2/peter/Documents/sysInfo
pid1=$!
echo $pid1
sleep 0.5
#sudo kill $pid1
#sudo kill -9 $pid1
pid="$(ps -ef | awk '/tegrastats/{print $2}')"
echo $pid1
sudo kill $pid

usage="$(cat /home2/peter/Documents/sysInfo/usage.txt)"
echo $usage

cpuusage="$(echo $usage | awk '/RAM/{print $6}')"
echo $cpuusage

#echo "temp" > sysInfo.txt
saveString="temp"

# temperatures of sensors
temps=$(sensors)
#echo $temps
#cputemp= "$(echo $temps | awk '/BCPU-therm-virtual-0/{print $6}')"
cputemp="$(echo $temps | awk '/BCPU-therm-virtual-0/{print $6}')"
echo "cputemp"
#echo $cputemp
#echo "cputempPrint"
cputempPrint="$(echo $cputemp | cut -c2-5)"
echo $cputempPrint
gputemp="$(echo $temps | awk '/GPU-therm-virtual-0/{print $24}')"
echo "gputemp"
#echo $gputemp
#echo "gputempPrint"
gputempPrint="$(echo $gputemp | cut -c2-5)"
echo $gputempPrint
#echo ",cpu" >> sysInfo.txt
saveString=$saveString",cpu,"
#echo $cputempPrint >> sysInfo.txt
saveString=$saveString$cputempPrint
#echo ",gpu," >> sysInfo.txt
saveString=$saveString",gpu,"
#echo $gputempPrint >> sysInfo.txt
saveString=$saveString$gputempPrint
#echo "usage" >> sysInfo.txt
saveString=$saveString",usage"



cpuusage=$(echo "${cpuusage:1:${#cpuusage}-2}")
echo $cpuusage
IFS=','        # space is set as delimiter
read -ra ADDR <<< "$cpuusage"    # str is read into an array as tokens separated by IFS
IFS="@"
cpuNum=0
for i in "${ADDR[@]}"; do    # access each element of array
    echo "$i"
    read -ra curProc <<< "$i"
    #echo ",cpu"$cpuNum >> sysInfo.txt
    saveString=$saveString",cpu"$cpuNum
    	#echo ",percent," >> sysInfo.txt
    #echo "," >> sysInfo.txt
    saveString=$saveString","
    #echo ${curProc[0]} >> sysInfo.txt
    saveString=$saveString${curProc[0]}
    	#echo ",frequency," >> sysInfo.txt
    #echo "," >> sysInfo.txt
    saveString=$saveString","
    #echo ${curProc[1]} >> sysInfo.txt
    saveString=$saveString${curProc[1]}
    let "cpuNum += 1"
done
IFS=""
gpuusage="$(echo $usage | awk '/RAM/{print $12}')"
echo "gpuusage"
echo $usage
echo $gpuusage
IFS="@"
read -ra gpuSep <<< "$gpuusage"
#echo ",gpu" >> sysInfo.txt
saveString=$saveString",gpu"
#echo "," >> sysInfo.txt
saveString=$saveString","
#echo ${gpuSep[0]} >> sysInfo.txt
saveString=$saveString${gpuSep[0]}
#echo "," >> sysInfo.txt
saveString=$saveString","
#echo ${gpuSep[1]} >> sysInfo.txt
saveString=$saveString${gpuSep[1]}
IFS=""

echo "$(ps -ef | awk '/tegrastats/{print $2}')"
hostname="$(cat /etc/hostname)"
echo $saveString > /home2/peter/Documents/sysInfo/sysInfo$hostname.txt
#sleep 10
#done
