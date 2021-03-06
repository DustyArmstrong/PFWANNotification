#!/bin/sh

#Script to compare current WAN IP to old WAN IP
#Will send an email via configured SMTP notifications
#Script by Dusty

currentwanip=$(cat /tmp/pppoe0_ip)

oldwanip=$(cat /tmp/old_wan_ip)

message="The WAN IP Has Changed\n\n
Old IP: $oldwanip\n\
New IP: $currentwanip\n\n
Modify VPN configurations for access."

subject="WAN IP Change"

if [ $currentwanip = $oldwanip ]; then
  exit
else
  # Send the email notification then update old IP
  printf "$message" | /usr/local/bin/mail.php -s="$subject"
  echo "$currentwanip" > /tmp/old_wan_ip
fi
