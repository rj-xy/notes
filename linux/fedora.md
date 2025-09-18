# Install Fedora

Nautilus edit Location/URL: <Ctrl>+L

SELinux: https://www.tecmint.com/disable-selinux-in-centos-rhel-fedora/

## Gnome 'gsettings' stuff (Get from Ubuntu)

```
sudo dnf update
sudo dnf install gnome-tweaks dnf-plugins-core openfortivpn

# Audio
rpm -qa \*pipewire\* \*wireplumber\*
sudo dnf install --allowerasing pipewire-pulseaudio
systemctl --user --now enable pipewire pipewire-pulse wireplumber
# systemctl --user restart pipewire pipewire-pulse wireplumber
systemctl --user status pipewire pipewire-pulse wireplumber
pactl info
```

VPN issue fix:
```
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
sudo rm /etc/resolv.conf
sudo systemctl restart  NetworkManager.service
```

Default to X11 (instead of Wayland)
https://docs.fedoraproject.org/en-US/quick-docs/configuring-xorg-as-default-gnome-session/
