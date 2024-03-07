#!/bin/bash

echo "Value of /proc/sys/fs/file-max"
cat /proc/sys/fs/file-max

echo "ulimit -n"
ulimit -n

echo "ulimit -u"
ulimit -u

echo "ulimit -Sn"
ulimit -Sn

echo "ulimit -Su"
ulimit -Su

echo "Top 15 of processes with open files:"
sudo lsof | awk '{ print $1 " " $2 }' | sort -n | uniq -c | sort -rn | head -15

echo "Changing systemd configuratin files..."
sudo sed -r -i -e "s/#DefaultLimitNOFILE=[0-9]+:[0-9]+/DefaultLimitNOFILE=524288:524288/g" /etc/systemd/system.conf

present_in_user_config=$(grep DefaultLimitNOFILE=524288:524288 /etc/systemd/user.conf)
if [ -z "$present_in_user_config" ]; then
	echo "DefaultLimitNOFILE=524288:524288" | sudo tee --append /etc/systemd/user.conf
fi

echo "Reloading systemd configuration files..."
sudo systemctl daemon-reexec

echo "Open a new terminal and try 'ulimit -n'..."

