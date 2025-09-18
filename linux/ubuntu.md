# ISO to USB
---> Just install the ISO to multi tool

Show drive/partitions
`lsblk`
Copy IMG/ISO to a USB device
`sudo dd bs=4M if=./XXX.iso of=/dev/sdx conv=fsync oflag=direct status=progress`

## HP Laptop
- F9 for boot menu
- secure boot password: `Fxxfxx5XXXXX`

## Keyboard
**NOTE**: Swap Fn keys: `Fn+Tab+F`

## Additional drivers

```
# display video adaptors
sudo lshw -c video
# List nvidia drivers
apt-cache search nvidia-driver

sudo ubuntu-drivers autoinstall
# OR -- Not desirable
sudo apt install nvidia-driver-535 nvidia-dkms-535

# Verify
nvidia-smi
```

## Gnome stuff:

```
gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true
gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '<Super>'
gsettings set org.gnome.desktop.peripherals.keyboard remember-numlock-state true
gsettings set org.gnome.desktop.peripherals.keyboard numlock-state true
# Remove existing emoji picker
gsettings set org.freedesktop.ibus.panel.emoji hotkey "[]"

gsettings set org.gnome.desktop.background picture-options 'none'
gsettings set org.gnome.desktop.background primary-color '#000000'
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"

echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
```

`sudo timedatectl set-timezone Australia/Brisbane`

## Settings:

- Search:
    - Leave ON, but turn OFF all individual options
- power:
    - power botton action: nothing
- keyboard shortcuts:
    - home folder super+e
    - disable all screenshot shortcuts
    - Add flameshot `/bin/flameshot gui`
- Set up fingerprint for User in settings
	- `sudo pam-auth-update`
		- Finger Print auth - enable

## Gnome Tweaks

- General
    - Laptop lid: off
- Extensions (Built-in - only turn these on)
    - Ubuntu app indicators
- Fonts: Scaling factor: 1.15
- keyboard: additional layout options:
    - Caps lock backspace
    - Compatibility options:
        - Both shift = caps lock, 1 shift to unlock
        - Numeric keypad keys always enter digits
- Extensions (To install):
    - Removable drive menu
    - Clipboard

## APT installs

```
sudo apt update
sudo apt upgrade -y
sudo apt install -y gnome-tweaks flameshot bash-completion qalculate-gtk \
build-essential kdiff3-qt gnome-shell-extension-manager git

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

## Fingerprint

sudo apt update
sudo apt install fprintd libpam-fprintd
sudo pam-auth-update

## Extensions

- Disable Ubuntu dock

## Snapcraft

- authy

```
killall snap-store
killall gnome-software
update
```

## Flatpak

- calibre
- Work: dbeaver

## Manual installs

- brave browser
- https://code.visualstudio.com/docs/setup/linux
- nvm
- Docker: https://docs.docker.com/engine/install/linux-postinstall/

### Screen recorder

Kooha (Wayland) or Kazam (XOrg only)

## XOrg

```
sudo nano /etc/gdm3/custom.conf
#
WaylandEnable=false
DefaultSession=ubuntu-xorg.desktop
#
sudo systemctl restart gdm3
```

## Terminal

Shortcuts:

- Switch to previous tab: Alt+Left
- Switch to next tab: Alt+Right
- Move tab (Left & Right): Disabled

## Locations:

```
# Ubuntu Repo
/etc/apt/sources.list
/etc/apt/sources.list.d/
# Systemd
/lib/systemd/system
/etc/systemd/system
/run/systemd/system
# misc
/etc/profile
```

## Add user to group

```
sudo usermod -aG GROUP_NAME $USER
# Reload group for user
newgrp GROUP_NAME
```
