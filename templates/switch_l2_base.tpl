enable
configure terminal
hostname __HOSTNAME__
ip domain-name __DOMAIN__
no ip domain-lookup
service password-encryption
enable secret __SECRET:ENABLESECRET__ algorithm-type scrypt
username __USER__ privilege 15 secret __SECRET:USERPASS__
banner motd ^__MOTDBANNER__^
ntp server __NTPSERVER__
line vty 0 4
 login local
 transport input ssh
 logging synchronous
 exit
vtp version 3
vtp mode client
vtp domain __VTPDOMAIN__
vtp password __SECRET:VTPPASS__ hidden
interface vlan 99
 ip address __SVI_99_IP__ __SVI_99_MASK__
 no shutdown
 exit
ip default-gateway __DEFAULT_GATEWAY__
spanning-tree mode rapid-pvst
end
write memory