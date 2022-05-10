## Delete the older vxlan10
ip link delete vxlan10

## Create VXLAN interface 
ip link add name vxlan10 type vxlan id 10 dev eth0 group 239.1.1.1 dstport 4789

## Config @IP for vxlan10 interface
ip addr add 20.1.1.1/24 dev vxlan10
ip link set dev vxlan10 up

## Associate vxlan and eth network eth1 to be part of one bridge !!! so make eth1 part of br0 
brctl addif br0 eth1
brctl addif br0 vxlan10
