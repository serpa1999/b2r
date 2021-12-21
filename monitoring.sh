clear
RAM_total=$(cat /proc/meminfo | grep MemTotal | awk '{ print $2 }')
RAM_free=$(cat /proc/meminfo | grep MemFree | awk '{ print $2 }')
echo "#Architecture: $(uname -a)"
echo "#CPU physical : $(cat /proc/cpuinfo | grep "cpu cores" | sed -n "1p" | awk '{ print $4 }')"
echo "#vCPU : $(nproc)"
echo "#Memory Usage: $(((RAM_total - RAM_free) / 1024))/$((RAM_total / 1024))MB ($(printf %.2f "$((100 *   (RAM_total - RAM_free)/RAM_total  ))e-2")%)"
echo "#Disk Usage: "
df -h /