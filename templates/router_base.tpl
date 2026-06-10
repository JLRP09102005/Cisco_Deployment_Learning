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
router ospf 1
 router-id __OSPFID__
 passive-interface default
exit
interface Loopback0
 ip ospf 1 area __OSPFAREA__
exit
end
write memory