## Router
Need to open ports: **9001**, **9030**
**Router**: https://192.168.1.1/#Security/Port_Forwarding
```
22,80,443,9001,9030
```

## Install

### Setup repo config
```
sudo nano /etc/apt/sources.list.d/tor.list
# Contents below of **/etc/apt/sources.list.d/tor.list** ----

deb [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org jammy main
deb-src [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org jammy main
```

### Install packages
```
wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --dearmor | sudo tee /usr/share/keyrings/tor-archive-keyring.gpg >/dev/null
sudo apt update
sudo apt install tor deb.torproject.org-keyring nyx
```

### Config and run
```
# edit for TOR relay
# https://github.com/torproject/tor/blob/main/src/config/torrc.sample.in
# https://www.wordexample.com/list/nouns-suffix-ance
sudo nano /etc/tor/torrc

sudo systemctl restart tor@default

# show logs
sudo journalctl -f -u tor@default

# Add user to tor group
sudo usermod -aG debian-tor $USER
newgrp debian-tor

nyx
```

### Relay search
`https://metrics.torproject.org/rs.html#`

### Vanity address
```
docker run -e FILTERS=GoatMoat marvambass/mkp224o

docker volume ls
# Get MOUNT_POINT (Mountpoint)
docker volume inspect VOL_ID
sudo ls MOUNT_POINT(/var/lib/docker/volumes.....) /address.onion
# Should show three files:
# hostname  hs_ed25519_public_key  hs_ed25519_secret_key
```