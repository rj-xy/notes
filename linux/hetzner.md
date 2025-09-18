https://community.hetzner.com/tutorials/basic-cloud-config

**Test on Qemu/LXD**: https://cloudinit.readthedocs.io/en/latest/tutorial/index.html
**Examples**: https://cloudinit.readthedocs.io/en/latest/reference/examples.html

Cloud-init script:
```yaml
#cloud-config
# Check: cloud-init status --wait

fqdn: jacq.cc
hostname: jacq.cc
locale: en_AU.UTF-8
timezone: Australia/Brisbane

manage-resolv-conf: true
resolv_conf:
  nameservers: ["1.1.1.1", "1.0.0.1"]

users:
  # 🔥 UPDATE USER
  - name: rj
    lock_passwd: true
    groups: sudo, users, admin, docker
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - "ssh-ed25519 xxxxx r@jacq.cc"
      - "ssh-ed25519 xxxxx r@jacq.cc"

# files:
#   - path: /home/rj/.bash_aliases
#     source: .bash_aliases
#   - path: /home/rj/compose.yaml
#     source: compose.yaml

# # https://cloudinit.readthedocs.io/en/0.7.9/topics/examples.html#add-apt-repositories
# apt:
#   primary:
#     - arches: [default]
#       search:
#         - http://archive.ubuntu.com
#         - https://mirror.aarnet.edu.au/ubuntu/
#         - http://au.archive.ubuntu.com/ubuntu
#         - http://security.ubuntu.com/ubuntu/

packages:
  - curl
  - ufw
  - sshguard
package_update: true
package_upgrade: true

runcmd:
  - sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
  - sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
  - sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1

  # ufw
  - ufw default deny incoming
  - ufw default allow outgoing
  # Custom SSH port, instead of 22
  - ufw limit 51265
  - ufw allow http
  - ufw allow https
  - ufw enable

  # sshd_config deny
  - sed -i 's/#\?\(PermitRootLogin\s*\).*$/\1 no/' /etc/ssh/sshd_config
  - sed -i 's/#\?\(PasswordAuthentication\s*\).*$/\1 no/' /etc/ssh/sshd_config
  - sed -i 's/#\?\(KbdInteractiveAuthentication\s*\).*$/\1 no/' /etc/ssh/sshd_config
  - sed -i 's/#\?\(ChallengeResponseAuthentication\s*\).*$/\1 no/' /etc/ssh/sshd_config
  - sed -i 's/#\?\(X11Forwarding\s*\).*$/\1 no/' /etc/ssh/sshd_config
  - sed -i 's/#\?\(AllowAgentForwarding\s*\).*$/\1 no/' /etc/ssh/sshd_config

  # sshd_config allow
  - sed -i 's/#\?\(Port\s*\).*$/\1 51265/' /etc/ssh/sshd_config
  - sed -i 's/#\?\(AllowTcpForwarding\s*\).*$/\1 yes/' /etc/ssh/sshd_config
  - sed -i 's/#\?\(MaxAuthTries\s*\).*$/\1 2/' /etc/ssh/sshd_config
  - sed -i 's/#\?\(AuthorizedKeysFile\s*\).*$/\1 .ssh\/authorized_keys/' /etc/ssh/sshd_config
  - sed -i '$a AllowUsers rj' /etc/ssh/sshd_config

  # docker
  - curl -fsSL https://get.docker.com -o get-docker.sh
  - sh ./get-docker.sh
  - usermod -aG docker rj
  - systemctl enable docker
  - systemctl enable containerd
  - curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

  - reboot
```

## QEMU

https://ubuntu.com/server/docs/boot-arm64-virtual-machines-on-qemu

```bash
# Just ARM arch
sudo apt install qemu-system-arm

# For all Arch
sudo apt install qemu-system
```

```bash
cd ~/Downloads

# https://wiki.ubuntu.com/Releases -> 24.04
# Original: https://cloud-images.ubuntu.com/noble/current/
# Faster mirror: https://mirrors.cloud.tencent.com/ubuntu-cloud-images/noble/current/

wget https://mirrors.cloud.tencent.com/ubuntu-cloud-images/noble/current/noble-server-cloudimg-arm64.img

# SHA256 Sums: tencent seem to be a few days older, so get the correct sums from:
# https://cloud-images.ubuntu.com/noble/
sha256sum ./noble-server-cloudimg-arm64.img
```

```bash
cat << EOF > user-data
#cloud-config
password: password
chpasswd:
  expire: False
EOF

cat << EOF > meta-data
instance-id: someid/somehostname
EOF

touch vendor-data
```

in a new shell: `python3 -m http.server --directory .`

```bash
qemu-system-arm64 
    -net nic                               \
    -net user                              \
    -machine virt-8.2                      \
    -m 512                           		   \
    -nographic                             \
    -hda noble-server-cloudimg-arm64.img   \
    -smbios type=1,serial=ds='nocloud;s=http://10.0.2.2:8000/'


# Below: /ubuntu.com/server/docs/boot-arm64-virtual-machines-on-qemu
truncate -s 64m varstore.img
truncate -s 64m efi.img
dd if=/usr/share/qemu-efi-aarch64/QEMU_EFI.fd of=efi.img conv=notrunc

sudo qemu-system-aarch64 \
 -m 2048\
 -cpu max \
 -M virt \
 -nographic \
 -drive if=pflash,format=raw,file=efi.img,readonly=on \
 -drive if=pflash,format=raw,file=varstore.img \
 -drive if=none,file=noble-server-cloudimg-arm64.img,id=hd0 \
 -device virtio-blk-device,drive=hd0 \
 -netdev type=tap,id=net0 \
 -device virtio-net-device,netdev=net0 \
 -smbios type=1,serial=ds='nocloud;s=http://10.0.2.2:8000/'

```

## LXD

```bash
sudo snap install lxd

sudo adduser rj lxd && newgrp lxd
lxd init --minimal
# OR manual
printf 'config: {}\ndevices: {}' | lxc profile edit default
lxc storage delete default
lxc network delete lxdbr0
lxd init

cat << EOF > user-data
#cloud-config
runcmd:
  - echo 'Hello, World!' > /var/tmp/hello-world.txt

EOF
```

```bash
# List of images: https://images.linuxcontainers.org/
# ubuntu:noble, ubuntu:noble/amd64
lxc launch ubuntu:noble my-test --config=user.user-data="$(cat ./user-data)"
lxc list

lxc shell my-test
#...
lxc delete --force my-test
```

> Inside the LXC container:
```bash
cloud-init status --wait
# status: done

# Print out the cloud-init contents
cloud-init query userdata

# Validate schema of init contents
cloud-init schema --system --annotate

```