# ISO to USB

Show drive/partitions
`lsblk`
Copy IMG/ISO to a USB device
`sudo dd bs=4M if=./XXX.iso of=/dev/sdx conv=fsync oflag=direct status=progress`

## See all other network machines
```
ip addr
sudo arp-scan -l --interface=INTERFACE_NAME
```

# Laptop stuff
`sudo apt-get install -y bash-completion`

`sudo nano /etc/systemd/logind.conf`

```
HandlePowerKey=ignore
HandleLidSwitch=ignore
```

`sudo service systemd-logind restart`

`sudo timedatectl set-timezone Australia/Brisbane`

Disable Wifi

```bash
sudo ip link set dev wlp8s0 down
# ensure wifi is turned off
sudo lshw -C network
```

# SSH with no passwords
`ssh-keygen -t ed25519 -C "rj@jacq"`
Automatic:
`ssh-copy-id rj@192.168.1.2`
Manually:
`~/.ssh/authorized_keys` <\- Add the xxx.pub contents to this file

```bash
# Edit Config file:
sudo nano /etc/ssh/sshd_config
```

```ini
# important
PermitRootLogin no
AuthenticationMethods "publickey"
PasswordAuthentication no
PermitEmptyPasswords no
UsePAM no
```

```bash
sudo systemctl restart sshd.service
sudo systemctl status sshd.service
```

# SSHGuard

```
sudo apt update
sudo apt install -y sshguard
sudo systemctl status sshguard

# edit config
sudo nano /etc/sshguard/sshguard.conf
sudo systemctl restart sshguard

# Show IP blocks
sudo nft list table ip sshguard
sudo systemctl status sshguard
```


**See "Server - Portainer + Proxy"**
Continue if using LXD


# SSH tunnel
```
ssh -L 30779:192.168.1.1:443   rj@jacq.cc
#      |-1-| |--- 2 ---| |-3-| |---4----|
# 1. Local port
# 2. Remote (internal) IP/Host
# 3. Remote port
# 4. USER@SSH_HOST

# EdgeOS
ssh -L 30779:192.168.1.1:443 rj@jacq.cc
```

# LXD

```
# sudo nano /etc/modules-load.d/modules.conf
overlay
bonding
br_netfilter
iptable_mangle
iptable_nat
ip_vs
ip_vs_dh
ip_vs_ftp
ip_vs_lblc
ip_vs_lblcr
ip_vs_lc
ip_vs_nq
ip_vs_rr
ip_vs_sed
ip_vs_sh
ip_vs_wlc
ip_vs_wrr
nf_nat
xfrm_user
xt_conntrack
xt_MASQUERADE
```

```
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1

# sudo sysctl net.ipv4.ip_forward=1
sudo apt-get install -y qemu-kvm bridge-utils libvirt-daemon-system libvirt-clients libvirt-daemon-driver-lxc

lxd init
# ensure physical network & btrfs

# https://www.davidc.net/sites/default/subnets/subnets.html?network=10.0.0.0&mask=27&division=1.0
lxc network set lxdbr0 ipv4.address 10.11.0.1/27
lxc network set lxdbr0 ipv4.dhcp.ranges 10.11.0.1-10.11.0.30
lxc network set lxdbr0 ipv4.dhcp.expiry=infinite
lxc network show lxdbr0

# reconfig
printf 'config: {}\ndevices: {}' | lxc profile edit default
lxc storage delete default
lxc network delete lxdbr0

# Restart the LXC/LXD service
sudo systemctl reload snap.lxd.daemon

# launch
lxc init ubuntu:22.04 ub1 \
	-c security.nesting=true \
	-c security.syscalls.intercept.setxattr=true \
	-c security.syscalls.intercept.mknod=true \
	-c security.privileged=true \
	-c limits.cpu=2 \
	-c limits.memory=2GB \

#lxc config set ub1 raw.lxc 'lxc.net.0.ipv4.address = 10.0.0.1/27'
# sudo nano /var/snap/lxd/common/lxd/networks/lxdbr0/dnsmasq.leases

# ???
# lxc config set ub1 linux.kernel_modules overlay
# lxc config set ub1 linux.kernel_modules br_netfilter
# lxc config set ub1 linux.kernel_modules ip_vs

mkdir -p /home/rj/ub1/docker/volumes
lxc config device add ub1 ub1-docker-volumes disk source=/home/rj/ub1/docker/volumes path=/var/lib/docker/volumes/
lxc config device show ub1

sudo apt-get update
lxc exec ub1 -- bash
```

In the Container now
```
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1

# install docker CE	: https://docs.docker.com/engine/install/ubuntu/
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose

curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# Add user to tor group
sudo usermod -aG docker $USER
newgrp docker

docker swarm init

sudo echo "10.11.0.18 ub1"|cat - /etc/hosts > /tmp/out && sudo mv /tmp/out /etc/hosts
cat /etc/hosts
# sudo nano /etc/hosts
```

# Portainer
```
# Install
curl -L https://downloads.portainer.io/portainer-agent-stack.yml \
    -o portainer-agent-stack.yml
docker stack deploy -c portainer-agent-stack.yml portainer

# Update
docker service update --image portainer/portainer-ce:latest --publish-add 9443:9443 --force portainer_portainer
docker service update --image portainer/agent:latest --force portainer_agent

# ---
docker volume create portainer_data

docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

```

docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

Portainer compose
```
version: '3.2'
services:
  port:
    container_name: port
    image: 'portainer/portainer-ce:latest'
    restart: unless-stopped
    ports:
      - '8000:8000'
	    - '9443:9443'
    volumes:
      - portainer_data:/data
      - /var/run/docker.sock:/var/run/docker.sock

volumes:
  portainer_data:
```

# HAProxy

```
sudo apt install -y haproxy
sudo nano /etc/haproxy/haproxy.cfg
#...
sudo systemctl restart haproxy.service
systemctl status haproxy.service
```

## /etc/haproxy/haproxy.cfg

```
defaults
        mode    tcp
        option  tcplog

frontend http
    mode tcp
    bind :80
    bind :81
    bind :443
    bind :9443
    default_backend swarm_nodes

backend swarm_nodes
    mode tcp
    balance roundrobin
    server ub1 10.0.0.3 check port 8000
    server ub2 10.0.0.4 check port 8000
```

# Nginx proxy

- Email: admin@example.com
- Password: changeme

```
version: '3.2'
services:
  proxy:
    container_name: proxy
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    volumes:
      - proxy_data:/data
      - proxy_letsencrypt:/etc/letsencrypt
    environment:
      DISABLE_IPV6: 'true'
    deploy:
      mode: replicated
      replicas: 1
      placement:
        constraints: [node.role == manager]

volumes:
  proxy_data:
  proxy_letsencrypt:
```

```
lxc exec ub1 -- bash
./lazydocker

# E - shell

apt update
apt install iproute2 iputils-ping telnet -y
```


# Docker on host - DO NOT USE!!!!

```
# show ip forward tables
sudo nft -s list chain ip filter FORWARD
sudo iptables -L FORWARD --line-numbers
sudo iptables -L

# flush iptables
sudo iptables -F
sudo iptables -F FORWARD

# Add iptable rule to allow LXC bridge port forwards
sudo iptables -A FORWARD -o lxdbr0 -j ACCEPT
sudo iptables -A FORWARD -i lxdbr0 -j ACCEPT

sudo iptables -A FORWARD -o docker0 -j ACCEPT
sudo iptables -A FORWARD -i docker0 -j ACCEPT


sudo iptables -I DOCKER-USER  -j ACCEPT

sudo systemctl restart docker
```

# DNS

## Public IP

```bash
# https://www.tecmint.com/find-linux-server-public-ip-address/
curl ifconfig.co
curl ifconfig.me
curl icanhazip.com
```

## Cloudflare

```bash
export CF_BEARER="bdtk-gRHuzignE8gadoKvO14ZPJTcny3hLf2NSDc"
curl -X GET "https://api.cloudflare.com/client/v4/user/tokens/verify" \
   -H "Authorization: Bearer $CF_BEARER" \
   -H "Content-Type:application/json"

curl -X GET "https://api.cloudflare.com/client/v4/zones?name=jacq.cc" \
   -H "Authorization: Bearer $CF_BEARER" \
   -H "Content-Type:application/json"

# zone: jacq.cc = 930431e9987b82b69ba8a2fe4a31e1b7
curl -X GET "https://api.cloudflare.com/client/v4/zones/930431e9987b82b69ba8a2fe4a31e1b7/dns_records" \
   -H "Authorization: Bearer $CF_BEARER" \
   -H "Content-Type:application/json"

# DNS: A jacq.cc: 28c41806d4833df8844770f7c09b3265
curl -X PATCH "https://api.cloudflare.com/client/v4/zones/930431e9987b82b69ba8a2fe4a31e1b7/dns_records/28c41806d4833df8844770f7c09b3265" \
   -H "Authorization: Bearer $CF_BEARER" \
   -H "Content-Type:application/json" \
     --data '{"content":"14.202.97.218"}'
```

# Edgemax

https://gist.github.com/xezpeleta/cf0a982419581415c29340051c0537d2
https://help.ui.com/hc/en-us/articles/204976324-EdgeRouter-Custom-Dynamic-DNS

```
# /etc/ddclient/ddclient_pppoe0.conf
 service custom-cloudflare {
     host-name jacq.cc
     login r@jacq.cc
     options "zone=jacq.cc use=web ssl=yes ttl=1"
     password GLOBAL-API-KEY
     protocol cloudflare
     server api.cloudflare.com/client/v4
 }
 web https://ipinfo.io/ip
```

CLI:

```bash
ssh 192.168.1.1 -p 2222

configure
show service dns dynamic interface pppoe0
set service dns dynamic interface pppoe0 service custom-cloudflare XXXX

commit ; save ; exit

sudo rm /var/cache/ddclient/ddclient_pppoe0.cache
sudo /usr/sbin/ddclient -daemon=0 -debug -verbose -noquiet -file /etc/ddclient/ddclient_pppoe0.conf

sudo rm /var/cache/ddclient/ddclient_pppoe0.cache
update dns dynamic interface pppoe0
show dns dynamic status

tail /var/log/messages
sudo cat /etc/ddclient/ddclient_pppoe0.conf
sudo vi /etc/ddclient/ddclient_pppoe0.conf
```

![1f405ee2a8b4154ad3ac2e125aa8d7cf.png](:/abbc050395fc41c8875e2d27629ad6a3)
