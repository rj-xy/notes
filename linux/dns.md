https://blog.bogdancaraman.com/configure-cloudflare-dns-debian-cli/

```bash
# If using systemd-resolved it should be:
# > nameserver 127.0.0.53
# > options edns0 trust-ad
# > search .
cat /etc/resolv.conf
```

```bash
sudo nano /etc/systemd/resolved.conf
```

```ini
# Set or modify the following lines:
DNS=1.1.1.1 1.0.0.1
FallbackDNS=2606:4700:4700::1111 2606:4700:4700::1001

# Save and exit (Ctrl+S, Ctrl+X)
```


```bash
sudo systemctl restart systemd-resolved

# Ensure /etc/resolv.conf points to the correct stub file:
sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

sudo systemctl restart NetworkManager

# Test
ping -c 4 google.com
dig example.com
```
