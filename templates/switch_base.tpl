enable
configure terminal
hostname __HOSTNAME__
ip domain-name __DOMAIN__
no ip domain-lookup
service password-encryption
enable secret __SECRET:ENABLESECRET__ algorithm-type scrypt
username admin privilege 15 secret __SECRET:USERPASS__
banner motd ^__MOTDBANNER__^
ntp server __NTPSERVER__
line vty 0 4
 login local
 transport input ssh
 logging synchronous
exit
router ospf 1
 router-id __OSPFID__
 passive-interface default
exit
ip routing
vtp version 3
vtp mode server
vtp domain __VTPDOMAIN__
vtp password __SECRET:VTPPASS__ hidden
vtp pruning
end
write memory
vlan 10
 name users
 exit
vlan 20
 name servers
 exit
vlan 30
 name RRHH
 exit
vlan 40
 name IT
vlan 99
 name administration
 exit
vlan 999
 name blackhole
 exit
interface vlan 10
 ip address __SVI_10_IP__ __SVI_10_MASK__
 exit
interface vlan 20
 ip address __SVI_20_IP__ __SVI_20_MASK__
 exit
interface vlan 30
 ip address __SVI_30_IP__ __SVI_30_MASK__
 exit
interface vlan 40
 ip address __SVI_40_IP__ __SVI_40_MASK__
 exit
interface vlan 99
 ip address __SVI_99_IP__ __SVI_99_MASK__
 exit
standby 1 ip __HSRP_GROUP1_IP__
standby 1 priority __HSRP_GROUP1_PRIORITY__
standby 1 preempt
standby 1 authentication md5 key-string __SECRET:HSRP_GROUP1_KEY__
standby 2 ip __HSRP_GROUP2_IP__
standby 2 priority __HSRP_GROUP2_PRIORITY__
standby 2 preempt
standby 2 authentication md5 key-string __SECRET:HSRP_GROUP2_KEY__