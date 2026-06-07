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
 name blackhole
 exit
