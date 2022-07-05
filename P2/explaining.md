# BGP - part II

## docker images 

Like the part one, we need to pull alpine and frrouting/frr images and config the frrrouting/frr image and get the router image ready.

pulling images :

```
docker pull alpine
```

after pulling and configuration (like the part one) is done, we gonna add the images to the _GNS3_ program :

- go to `edit`>`preferences`>`Docker`>`Docker containers`
- for the machines : (alpine)
	- `New` after that choose docker image `alpine`.
	- choose 2 adapter.
	- stay clicking next until the dialog end.
- for the routers : (frr)
	- `New` after that choose docker image `frr`.
	- choose 2 adapters.
	- stay clicking next until the dialog end.

after that, we're going to change the default symbol for `router` image on _GNS3_ :
on the Menu bar Click on `Browse all devices` the look for `router` then `right click`>`Configure template`
then look for `Symbol` row and choose `Browse` then choose the symbole like the topology on the pdf.

to here we're ready to start our VXLAN configuration on the gns3.
we're going to Drag&Drop from gns3 devices and adding our interfaces links like the topology.
and then rename the devices like the topology.

### configuration VXLAN :

to run the machine into a terminal we're going to `right click on specific machine` then choose `Auxiliary Console` option.

### configuration routeurs :

router_will-1 :

- create a virtual device type bridge :
	``ip link add br0 type bridge``
	``ip link set dev br0 up``

- then, add a ip address for interface `eth0` (connected to the `switch_will`) 
	``ip addr add 30.1.1.1/24 dev eth0``

- add a vxlan interface named by vxlan10 with a id of 10, passing through `eth0` to the specified IP addresse :
	``ip link add name vxlan10 type vxlan id 10 dev eth0 remote <eth0 IP address of the other router> dstport 4789``

- then, add a ip address for the vxlan interface : 
	``ip addr add 20.1.1.1/24 dev vxlan10``

- call bridge controlle to link devices eth1 (connected to host_will-1) and vxlan10 device.
	``brctl addif br0 eth1``
	``brctl addif br0 vxlan10``

- make vxlan10 active
	``ip link set dev vxlan10 up``

router_will-2 :
	``
	ip link add br0 type bridge
	ip link set dev br0 up
	ip addr add 30.1.1.2/24 dev eth0
	ip link add name vxlan10 type vxlan id 10 dev eth0 remote 30.1.1.1 dstport 4789
	ip addr add 20.1.1.2/24 dev vxlan10
	brctl addif br0 eth1
	brctl addif br0 vxlan10
	ip link set dev vxlan10 up
	``
### configuration machines :

host_will-1 :
	``ip addr add 20.1.1.10/24 dev eth1``


host_will-2 :
	``ip addr add 20.1.1.20/24 dev eth1``


### Multi-routing confirguration :

### routers configuration :

router_will-1 :
	``
	ip link add br0 type bridge
	ip link set dev br0 up
	ip addr add 30.1.1.1/24 dev eth0
	ip link add name vxlan10 type vxlan id 10 dev eth0 group <group ip address (239.1.1.1 like subject)> dstport 4789
	ip addr add 20.1.1.1/24 dev vxlan10
	brctl addif br0 eth1
	brctl addif br0 vxlan10
	ip link set dev vxlan10 up
	``

router_will-2 :
	``
	ip link add br0 type bridge
	ip link set dev br0 up
	ip addr add 30.1.1.2/24 dev eth0
	ip link add name vxlan10 type vxlan id 10 dev eth0 group 239.1.1.1 dstport 4789
	ip addr add 20.1.1.2/24 dev vxlan10
	brctl addif br0 eth1
	brctl addif br0 vxlan10
	ip link set dev vxlan10 up
	``

### machine configuration :
host_will-1 :
	``ip addr add 20.1.1.10/24 dev eth1``

host_will-2 :
	``ip addr add 20.1.1.20/24 dev eth1``

