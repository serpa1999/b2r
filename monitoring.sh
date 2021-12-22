clear
RAM_total=$(cat /proc/meminfo | grep MemTotal | awk '{ print $2 }')
RAM_free=$(cat /proc/meminfo | grep MemFree | awk '{ print $2 }')
MEM_total=$(du / -s 2>/dev/null | awk '{ print $1 }')
echo "#Architecture: $(uname -a)"
echo "#CPU physical : $(cat /proc/cpuinfo | grep "cpu cores" | sed -n "1p" | awk '{ print $4 }')"
echo "#vCPU : $(nproc)"
echo "#Memory Usage: $(((RAM_total - RAM_free) / 1024))/$((RAM_total / 1024))MB ($(printf %.2f "$((1000000000 *   (RAM_total - RAM_free)/RAM_total  ))e-7")%)"
echo "#Disk Usage: $((MEM_total/1024))"
grep 'cpu' /proc/stat