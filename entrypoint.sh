#!/bin/sh
echo type : ${type}
echo 14
mkdir -p /dev/net
mknod /dev/net/tun c 10 200
chmod 666 /dev/net/tun
cat /dev/net/tun
ls -l /dev/net/tun

echo supernode: $supernodenet
echo interfaceaddress: $interfaceaddress
echo tun : $(lsmod | grep tun)
if [[ ${type} == "supernode" ]]; then
        /usr/local/sbin/supernode --help
        /usr/local/sbin/supernode -p $listenport -f $OPTIONS
elif [[ ${type} == "edge" ]]; then
        # /usr/local/sbin/edge --help
        /usr/local/sbin/edge -d $devicename -a $interfaceaddress -c $communityname -k $Encryptionkey -l $supernodenet -f $OPTIONS  
fi
