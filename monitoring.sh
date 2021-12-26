clear
RAM_total=$(free -m | awk '$1 == "Mem:" {print $2}')
RAM_used=$(free -m | awk '$1 == "Mem:" {print $3}')
MEM_total=$(df -Bm | grep '^/dev/' | grep -v 'boot' | awk '{ a += $2 } END { print a }')
MEM_used=$(df -Bm | grep '^/dev/' | grep -v 'boot' | awk '{ b += $3 } END { print b }')
wall "	#Architecture: $(uname -a)
	#CPU physical : $(cat /proc/cpuinfo | grep "physical id" | uniq | wc -l)
	#vCPU : $(cat /proc/cpuinfo | grep "^processor" | wc -l)
	#Memory Usage: $RAM_used/$((RAM_total))MB ($(printf %.2f "$(((1000000000 * RAM_used)/RAM_total  ))e-7")%)
	#Disk Usage: $MEM_used/$((MEM_total/1024))GB ($(printf %.2f "$(((1000000000 * MEM_used)/MEM_total  ))e-7")%)
	#CPU load: $(top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f"), $1 + $3}')%
	#Last boot: $(who -b | awk '{ print $3 " " $4 }')
	#LVM use: $(if [ $(lsblk | grep LVM | wc -l) -eq 0 ]; then echo no; else echo yes; fi)
	#Connnections TCP : $(cat /proc/net/sockstat | awk '$1 == "TCP:" {print $3 " ESTABLISHED"}')
	#User log: $(users | wc -w)
	#Network: IP $(hostname -I) ($(ip link show | awk '$1 == "link/ether" {print $2}'))
	#Sudo : $(journalctl _COMM=sudo | grep COMMAND | wc -l) cmd"