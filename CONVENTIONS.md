## INVENTORY
- loopback_ip -> ip configured as loopback interface to manage the device using ssh, and using it as OSPF ID also
- type -> the device type (router, switch...) used to choose the template file
- name -> the name that identifies the device in topology
- user -> the username for the local user login
- ospf_area -> the area where the device is located using OSPF

## VARS FILES
- HOSTNAME -> the name of the device
- DOMAIN -> the device domain name
- VTPDOMAIN -> domain name for VTP
- SVI_VLANX_IP -> ip for vlan svi x
- SVI_VLANX_MASK -> ip mask for vlan svi x
- OSPF_AREA_VLANX -> the area of the svi inside OSPF software
- HSRP_PRIORITY_VLANX -> the priority of the interface using HSRP
- STP_VLANX -> the STP priority for the vlan x
- DEFAULT_GATEWAY -> set the default gateway for l2 switchs
- LOOPBACKX_MASK -> ip mask for loopback x interface
- OSPF_AREA_LOOPBACKX -> the area of the loopback x interface using OSPF