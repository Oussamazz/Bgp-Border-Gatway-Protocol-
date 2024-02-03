# Network Administration Project: BGP at Doors of Autonomous Systems is Simple (BADASS)

This repository contains my work on a complex yet rewarding project aimed at deepening our knowledge of network administration. The project involved setting up and managing a network using GNS3 and Docker, discovering a VXLAN, and exploring BGP with EVPN.

## Table of Contents

- [Project Overview](#project-overview)
- [Part 1: Configuring GNS3 with Docker](#part-1-configuring-gns3-with-docker)
- [Part 2: Discovering a VXLAN](#part-2-discovering-a-vxlan)
- [Part 3: Discovering BGP with EVPN](#part-3-discovering-bgp-with-evpn)
- [Conclusion](#conclusion)

## Project Overview

The project revolved around three main components:

1. Setting up and configuring GNS3 and Docker in a virtual machine.
2. Establishing a VXLAN network and managing its configuration.
3. Exploring the principles of BGP EVPN without using MPLS.

Each component was tackled in detail, with careful documentation and explanations of the configurations made.

## Part 1: Configuring GNS3 with Docker

In this part, we configured GNS3 and Docker in a virtual machine. We created two Docker images, one with a basic system including busybox or equivalent, and another with specific requirements such as packet routing software (zebra or quagga), active BGPD and OSPFD services, and a routing engine service. These images were then tested and validated in GNS3 with the required services.

## Part 2: Discovering a VXLAN

The next step involved setting up a VXLAN network (RFC 7348) both statically and dynamically multicast. We configured the network using VXLAN with ID 10 and set up a bridge named br0. The traffic between the two machines in the VXLAN was then inspected to ensure everything was working correctly.

## Part 3: Discovering BGP with EVPN

In the final part, we delved deeper into the principles of VXLAN and explored BGP EVPN (rfc 7432) without using MPLS. The controller learned MAC addresses and we used the previously set up VXLAN with ID 10. We configured the leaf nodes (VTEP) for dynamic relationships and used OSPF for simplicity.

## Conclusion

This project was a journey through the intricacies of network administration, providing valuable hands-on experience with GNS3, Docker, VXLAN, and BGP EVPN. It was challenging but incredibly rewarding, offering a deep understanding of how these technologies interact and function together to form robust and efficient networks.
