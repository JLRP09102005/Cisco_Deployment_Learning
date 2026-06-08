enable
configure terminal
hostname __HOSTNAME__
service password-encryption
enable secret __SECRET:ENABLESECRET__ algorithm-type scrypt
username admin privilege 15 secret __SECRET:USERPASS__
banner motd ^__MOTDBANNER__^
ntp server __NTPSERVER__
line vty 0 4
 login local
 transport input ssh
 logging asynchronous
 exit
vtp version 3
vtp mode client
vtp domain __VTPDOMAIN__
vtp password __SECRET:VTPPASS__ hidden
vtp pruning