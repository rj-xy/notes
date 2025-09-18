# File: /etc/systemd/journald.conf

```bash
# /etc/systemd/journald.conf

[Journal]
# "volatile", "persistent", "auto" and "none"
# "auto" behaves like "persistent" if the /var/log/journal directory exists, and "volatile" otherwise
Storage=volatile
SystemMaxUse=100M
RuntimeMaxUse=100M
```

```bash
sudo systemctl restart systemd-journald
sudo systemctl status systemd-journald
```
