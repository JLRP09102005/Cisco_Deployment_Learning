enable
configure terminal
hostname __HOSTNAME__
ip domain-name __DOMAIN__
service password-encryption
enable secret __PRIVILEGEDPASS__ algorithm-type scrypt
username admin privilege 15 secret __USERPASS__
ip routing
vtp version 3
vtp mode server
vtp domain TEST
vtp password __VTPPASS__ hidden
vtp pruning
no vtp ethernet0/0
no vtp ethernet0/1