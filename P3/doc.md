

# Part 3: BGP - eVPN

we will create routeurs / hosts topology.

## interface naming (check 42-subject)

### host (`host_yoelguer-1`)

```sh
$ ip link set eth0 down
$ ip link set eth0 name eth1
$ ip link set eth1 up
```

### routeur (`_yoelguer-4`)

```sh
$ ip link set eth1 down
$ ip link set eth1 name eth2
$ ip link set eth2 up
```

---
## Routeurs & FRRouting
FRR is free software that implements and manages various IPv4 and IPv6 routing protocols.
It runs on nearly all distributions of Linux and BSD and supports all modern CPU architectures.

## Configuration des VTEP

In our subject the _VTEP_ (Virtual Termination End-Point), (3 VTEPs)
our "**Leafs**" on the topology, we will configure them first.

### router 2 (first leaf)

```sh
$ brctl addbr br0 # bridge create
$ ip link set up dev br0 # bridge activate
$ ip link add vxlan10 type vxlan id 10 dstport 4789 # create vxlan interface 
$ ip link set up dev vxlan10 # activation of interface vxlan
$ brctl addif br0 vxlan10 # adding vxlan to bridge
$ brctl addif br0 eth1 # adding eth1 to bridge

$ vtysh # open vtysh

$ config t # configuration

$ hostname <vtep name> #  routeur_yoelguer-2
$ no ipv6 forwarding # no forwarding in ipv6

## Setup interface eth0
$ interface eth0
$ ip address 10.1.1.2/30
$ ip ospf area 0

## Setup interface lo
$ interface lo
$ ip address 1.1.1.2/32
$ ip ospf area 0

## Setup bgp
$ router bgp 1
$ neighbor 1.1.1.1 remote-as 1
$ neighbor 1.1.1.1 update-source lo

## Setup evpn
$ address-family l2vpn evpn
$ neighbor 1.1.1.1 activate
$ advertise-all-vni
$ exit-address-family

$ router ospf

```

### router 3

```sh

$ vtysh
$ config t # configuration

$ hostname <nom du reflecteur> #  routeur_yoelguer-3
$ no ipv6 forwarding # no forwarding in ipv6

## Setup interface eth1
$ interface eth1
$ ip address 10.1.1.6/30
$ ip ospf area 0

## Setup interface lo
$ interface lo
$ ip address 1.1.1.3/32
$ ip ospf area 0

## Setup bgp
$ router bgp 1
$ neighbor 1.1.1.1 remote-as 1
$ neighbor 1.1.1.1 update-source lo

## Setup evpn
$ address-family l2vpn evpn
$ neighbor 1.1.1.1 activate
$ exit-address-family

$ router ospf

```

### router 4

```sh

$ brctl addbr br0 #
$ ip link set up dev br0 # 
$ ip link add vxlan10 type vxlan id 10 dstport 4789 # 
$ ip link set up dev vxlan10 # 
$ brctl addif br0 vxlan10 #
$ brctl addif br0 eth0 # 

$ vtysh 

$ config t 

$ hostname <vtep name> # routeur_yoelguer-4
$ no ipv6 forwarding # 

## Setup interface eth2
$ interface eth2
$ ip address 10.1.1.10/30
$ ip ospf area 0

## Setup interface lo
$ interface lo
$ ip address 1.1.1.4/32
$ ip ospf area 0

## Setup bgp
$ router bgp 1
$ neighbor 1.1.1.1 remote-as 1
$ neighbor 1.1.1.1 update-source lo

## Setup EVPN
$ address-family l2vpn evpn
$ neighbor 1.1.1.1 activate
$ advertise-all-vni
$ exit-address-family

$ router ospf

```



---

## hosts Configuration

-We will assing ip to our hosts:

### host 1

```sh
$ ip addr add 20.1.1.1/24 dev eth1
```
### host 2

```sh
$ ip addr add 20.1.1.2/24 dev eth0
```
### host 3

```sh
$ ip addr add 20.1.1.3/24 dev eth0
```

---

## Configuration du RR (route reflector) (`_yoelguer-1`)

we will configure our frr:

```sh
$ vtysh #

$ config t #

$ hostname <frr name> #  routeur_yoelguer-1
$ no ipv6 forwarding #

## Setup interface eth0
$ interface eth0
$ ip address 10.1.1.1/30

## Setup interface eth1
$ interface eth1
$ ip address 10.1.1.5/30

## Setup interface eth2
$ interface eth2
$ ip address 10.1.1.9/30

## Setup interface lo
$ interface lo
$ ip address 1.1.1.1/32

## Setup bgp
$ router bgp 1
$ neighbor ibgp peer-group
$ neighbor ibgp remote-as 1
$ neighbor ibgp update-source lo
$ bgp listen range 1.1.1.0/29 peer-group ibgp

## Setup evpn
$ address-family l2vpn evpn
$ neighbor ibgp activate
$ neighbor ibgp route-reflector-client
$ exit-address-family

$ router ospf
$ network 0.0.0.0/0 area 0

$ line vty
```