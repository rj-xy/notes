# IPFS

https://github.com/ipfs/kubo/issues/1430

https://github.com/ipfs/kubo/blob/master/misc/systemd/ipfs.service

```
cd Downloads

wget https://dist.ipfs.tech/kubo/v0.16.0/kubo_v0.16.0_linux-amd64.tar.gz
tar -xvzf kubo_v0.16.0_linux-amd64.tar.gz

cd kubo
sudo bash install.sh
rm -rf ./kubo*

ipfs --version
ipfs init --profile server

ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001
ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080

sudo nano /etc/systemd/system/ipfs.service
#sudo systemctl edit ipfs.service
```

```
[Unit]
Description=InterPlanetary File System (IPFS) daemon
Documentation=https://docs.ipfs.tech/
After=syslog.target network.target remote-fs.target nss-lookup.target

[Service]
Type=simple
ExecStart=/usr/local/bin/ipfs daemon --enable-namesys-pubsub
User=rj

[Install]
WantedBy=multi-user.target
```

```
sudo systemctl daemon-reload
sudo systemctl enable ipfs
sudo systemctl restart ipfs
sudo systemctl status ipfs.service

ipfs swarm peers
```


```
ipfs daemon > /dev/null &
export IPFS_PID=$!
echo $IPFS_PID

ipfs swarm peers
```

# Local Web UI
http://localhost:5001/webui/

# Public gateways
https://ipfs.github.io/public-gateway-checker/

# Gateway services: https://docs.ipfs.io/concepts/ipfs-gateway/#gateway-types
`https://{GATEWAY_URL}/ipfs/{CONTENT_ID}/{optional-path-to-resource}`
