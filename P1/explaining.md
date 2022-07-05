part one 
install docker and gns3
pull from docker images:
 	frrouting and gns3 , alpine
...
change to gnome flashback metacity

setup the gns3
first we need to add frr1 and frr2 , alpin1, aline2 to the interface
connecting


auxiliary console:
cat /etc/frr/daemons

ps : we need to see that zebra and bgpd....is runing

vtysh

show interface : sh int

first frr:
 conf t

 int lo  => ip addr 1.1.1.1/32
 int eth0 => ip addr 10.1.1.1/30

 router ospf
 network 0.0.0.0/0 are 0

scnd frr:

conf t

 int lo  => ip addr 1.1.1.2/32
 int eth0 => ip addr 10.1.1.2/30

 router ospf
 network 0.0.0.0/0 are 0

 do sh ip ospf interface
 do sh ip ospf neighbor
  do sh ip ospf router 
  do ping 1.1.1.1 : from frr2



  router isis 1 : enable isis

  net 49.0000.0000.0002.00 : privite 
int lo => ip router isis 1 
int eth0 => ip router isis 1

do sh isis int
do sh isis neighbor
do sh ip route





