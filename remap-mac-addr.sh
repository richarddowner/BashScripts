#!/bin/bash
#
# Adds a new ethernet interface config file
# use when the VM has been assigned a new MAC Address
#
###############
# VARIABLES
###############

ETH=`ifconfig -a | grep HWaddr`                  # Ethernet config line
MAC=${ETH:37}                                    # Get MAC Address
MAC="${MAC#"${MAC%%[![:space:]]*}"}"             # Remove leading whitespace characters
MAC="${MAC%"${MAC##*[![:space:]]}"}"             # Remove trailing whitespace characters
ETH=${ETH:0:4}                                   # Get Ethernet interface number
ETHNAME='ifcfg-'$ETH                             # Get Ethernet interface name
CONFIGFILES='/etc/sysconfig/network-scripts/'

###############

# Remove old eth config files
rm -fr /etc/sysconfig/network-scripts/ifcfg-eth*

# Make new eth config file
echo "DEVICE="$ETH > $CONFIGFILES/$ETHNAME
echo "HWADDR=$MAC" >> $CONFIGFILES/$ETHNAME
echo "TYPE=Ethernet" >> $CONFIGFILES/$ETHNAME
echo "UUID=ccb21348-0a9b-40e0-872c-108550f70265" >> $CONFIGFILES/$ETHNAME
echo "ONBOOT=yes" >> $CONFIGFILES/$ETHNAME
echo "NM_CONTROLLED=yes" >> $CONFIGFILES/$ETHNAME
echo "BOOTPROTO=dhcp" >> $CONFIGFILES/$ETHNAME

# Restart networking
/etc/init.d/network stop
/etc/init.d/network start
