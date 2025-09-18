## UFW
```bash
sudo ufw allow 22022/tcp
sudo ufw allow https

sudo ufw allow to 172.17.0.0/24

sudo ufw status

sudo ufw enable

# sudo ufw allow ssh
# sudo ufw allow from 192.168.1.0/24

# sudo ufw logging low
# sudo journalctl --follow
```

 ## Ubuntu PRO
```
sudo apt install ubuntu-advantage-tools
sudo pro attach CXXXXXXXXXXxxxxxxXXXXXXXXXX5
sudo pro enable usg
```

## JournalCTL
```
# 👉👉👉 See: /etc/systemd/journald.conf
sudo nano /etc/systemd/journald.conf
sudo systemctl restart systemd-journald
sudo systemctl status systemd-journald
```
