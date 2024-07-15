#!/bin/bash


echo "Monitoring $(date)" > system_monitor.log
echo "" >> system_monitor.log

echo "Wykorzystanie  CPU:" >> system_monitor.log
top -bn1 | grep "Cpu(s)" | \
sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
awk '{print 100 - $1"%"}' >> system_monitor.log
echo "" >> system_monitor.log

echo "Wykorzystanie pamieci:" >> system_monitor.log
free -h | grep Mem | awk '{print $3 " / " $2 " (" $3/$2*100 "%)"}' >> system_monitor.log
echo "" >> system_monitor.log

echo "Wykorzystanie Dysku:" >> system_monitor.log
disk_info=$(df -h / | awk 'NR==2{print "Dysk: " $2 " Wykorzystano: " $3 " Wolno: " $4 " (" $5 ")"}')
echo "$disk_info" >> system_monitor.log
echo "" >> system_monitor.log

cat system_monitor.log
