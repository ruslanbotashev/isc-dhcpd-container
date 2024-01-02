#!/bin/bash

set -xe


data_dir="/data"
if [ ! -d "$data_dir" ]; then
    echo "Please ensure '$data_dir' folder is available."
    exit 1
fi

dhcpd_conf="$data_dir/dhcpd.conf"
if [ ! -r "$dhcpd_conf" ]; then
    echo "Please ensure '$dhcpd_conf' exists and is readable."
    exit 1
fi

# create user, to allow dhcpd using external files
uid=$(stat -c%u "$data_dir")
gid=$(stat -c%g "$data_dir")
dhcpd_uid=$(id -u dhcpd)
if [ $gid -ne 0 ]; then
    groupmod -og $gid dhcpd
fi
if [ $uid -ne $dhcpd_uid ]; then
    usermod -ou $uid dhcpd
fi

[ -e "$data_dir/dhcpd.leases" ] || touch "$data_dir/dhcpd.leases"
chown dhcpd:dhcpd "$data_dir/dhcpd.leases"
if [ -e "$data_dir/dhcpd.leases~" ]; then
    chown dhcpd:dhcpd "$data_dir/dhcpd.leases~"
fi

exec /usr/sbin/dhcpd -4 -d -f --no-pid -cf "$data_dir/dhcpd.conf" -lf "$data_dir/dhcpd.leases" -user dhcpd -group dhcpd