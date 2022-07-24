# VirtualBox Environment for Whonix Gateway

## Requirements

- VirtualBox
- Vagrant

## (Optional) Build Vagrant Boxes

```bash
cd packer
export PACKER_LOG=1

export WHONIX_OVA=~/Downloads/Whonix-CLI-15.0.0.9.4.ova
packer build whonix.json

```

## (Optional) Upload Vagrant Boxes

```bash
vagrant cloud auth login --token "<CLOUD_TOKEN>"
vagrant cloud publish --force --release <USERNAME>/whonix-gateway 15.0.0.9.4 virtualbox whonix-gateway.box
```

## Run Vagrant Boxes

1. Run:
   ```bash
   vagrant up
   ```
