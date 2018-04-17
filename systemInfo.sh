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

echo "temp" > sysInfo.txt

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
echo ",cpu" >> sysInfo.txt
echo "," >> sysInfo.txt
echo $cputempPrint >> sysInfo.txt
echo ",gpu" >> sysInfo.txt
echo "," >> sysInfo.txt
echo $gputempPrint >> sysInfo.txt

echo "usage" >> sysInfo.txt


cpuusage=$(echo "${cpuusage:1:${#cpuusage}-2}")
echo $cpuusage
IFS=','        # space is set as delimiter
read -ra ADDR <<< "$cpuusage"    # str is read into an array as tokens separated by IFS
IFS="@"
cpuNum=0
for i in "${ADDR[@]}"; do    # access each element of array
    echo "$i"
    read -ra curProc <<< "$i"
    echo ",cpu"$cpuNum >> sysInfo.txt
    #echo ",percent," >> sysInfo.txt
    echo "," >> sysInfo.txt
    echo ${curProc[0]} >> sysInfo.txt
    #echo ",frequency," >> sysInfo.txt
    echo "," >> sysInfo.txt
    echo ${curProc[1]} >> sysInfo.txt
    let "cpuNum += 1"
done
IFS=""
gpuusage="$(echo $usage | awk '/RAM/{print $12}')"
echo "gpuusage"
echo $usage
echo $gpuusage
IFS="@"
read -ra gpuSep <<< "$gpuusage"
echo ",gpu" >> sysInfo.txt
echo "," >> sysInfo.txt
echo ${gpuSep[0]} >> sysInfo.txt
echo "," >> sysInfo.txt
echo ${gpuSep[1]} >> sysInfo.txt
IFS=""

echo "$(ps -ef | awk '/tegrastats/{print $2}')"
#sleep 10
#done
