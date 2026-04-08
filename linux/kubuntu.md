### Install Brave: instructions on website
### Install Edge: .deb file

### APT installs

```
sudo apt update
sudo apt upgrade -y
sudo apt install -y flameshot bash-completion qalculate-gtk \
    build-essential software-properties-gtk git \
  jq python-is-python3 python3-pip postgresql-client

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

### Node
```
# https://github.com/nvm-sh/nvm
nvm install --lts
nvm use --lts
```

### Yarn
```
corepack enable
corepack prepare yarn@stable --activate
yarn set version stable
```

### AWS CLI: 
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

### Set Hostname
```
# Option 1
sudo nmtui

#option 2
hostnamectl set-hostname sl-lx-rj
hostnamectl
```

### Shortcuts
- Shortcuts -> delete spectacle
- Shortcuts -> Add application -> Flameshot

### Other
```
# Download: dbeaver - .deb file
# Read: https://github.com/dsifford/yarn-completion
```

### Laptop (DELL/HP) Firmware
```
fwupdmgr refresh --force
fwupdmgr update
```

### Fingerprint
```bash
sudo apt install fprintd
sudo fprintd-enroll
sudo pam-auth-update
# OR Settings - > User - > Add finger
```


## UFW
```bash
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw enable
# List rules
sudo ufw status verbose
```

## Ubuntu PRO
Get an ubuntu PRO licence/key: https://ubuntu.com/pro/subscribe
```bash
sudo pro attach <token>
# Show all modules enabled - default ones are fine
pro status --all
```

## Microsoft sources for 24.04
```bash
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/24.04/prod noble main" > /etc/apt/sources.list.d/microsoft-ubuntu-noble-prod.list'
sudo rm microsoft.gpg
```

### Defender
```bash
sudo apt-get install mdatp

mdatp exclusion folder add --path ~/src
mdatp exclusion folder add --path ~/rj

sudo mdatp exclusion process add --name node
sudo mdatp exclusion process add --name deno

# https://learn.microsoft.com/en-us/defender-endpoint/linux-install-manually#ubuntu-and-debian-systems-1
# Get WindowsDefenderATPOnboardingPackage.zip from Tom
unzip WindowsDefenderATPOnboardingPackage.zip
# edit MicrosoftDefenderATPOnboardingLinuxServer.py -> remove the \o from L11
nano ./MicrosoftDefenderATPOnboardingLinuxServer.py
# Register
sudo python3 MicrosoftDefenderATPOnboardingLinuxServer.py

# confirm
mdatp health --field org_id
mdatp health --field healthy

# Add an exclusion
sudo mdatp exclusion folder add --path [Sauron root path, e.g. /home/rj/src]
sudo mdatp exclusion process add --name jest
sudo mdatp exclusion process add --name node
sudo mdatp exclusion list

# Enable stats
sudo mdatp config real-time-protection-statistics --value enabled

# Enable RT protection
sudo mdatp config real-time-protection --value enabled

# Display RT protection details
mdatp diagnostic real-time-protection-statistics

# Show threats
mdatp threat list
```

### Intune
Install docos:
https://learn.microsoft.com/en-us/mem/intune/user-help/microsoft-intune-app-linux
```bash
# Install Edge

sudo apt install intune-portal
systemctl --user daemon-reload

journalctl --follow
# Open intune App - IMPORTANT: after email, click on "use other method", do not use Password auth
```

Troubleshooting:
https://github.com/recolic/microsoft-intune-archlinux

!!!Ensure all Devices are removed from Intra Admin

Cleanup App (does not remove config and cache files, see below):
```
sudo apt remove microsoft-identity-broker
sudo apt purge microsoft-identity-broker
sudo apt remove intune-portal
sudo apt purge intune-portal
```

Delete files/folders for intune and identity-provider:
```
# Cleanup
rm -rf ~/.config/microsoft-identity-broker
sudo rm -rf /var/lib/microsoft-identity-device-broker
rm -f ~/.local/state/log/microsoft-identity-broker
mkdir -p ~/.config/microsoft-identity-broker

sudo systemctl restart microsoft-identity-device-broker.service
systemctl restart --user microsoft-identity-broker.service
sudo systemctl restart intune-daemon.service 
```
