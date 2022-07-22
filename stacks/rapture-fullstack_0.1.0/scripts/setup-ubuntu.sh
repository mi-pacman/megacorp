#!/bin/bash
set -x

# Install necessary dependencies
sudo apt update
sudo apt upgrade -y
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
sudo apt install -y -qq tmux curl wget git vim apt-transport-https ca-certificates docker.io

# Setup sudo to allow no-password sudo for "hashicorp" group and adding "terraform" user
sudo groupadd -r hashicorp
sudo useradd -m -s /bin/bash terraform
sudo usermod -a -G hashicorp terraform
sudo cp /etc/sudoers /etc/sudoers.orig
echo "terraform  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/terraform

# Installing SSH key
sudo mkdir -p /home/terraform/.ssh
sudo chmod 700 /home/terraform/.ssh
sudo cp /tmp/tf-packer.pub /home/terraform/.ssh/authorized_keys
sudo chmod 600 /home/terraform/.ssh/authorized_keys
sudo chown -R terraform /home/terraform/.ssh

# Configure traefik proxy
sudo mkdir /etc/traefik
sudo cp /vagrant/configs/traefik.yml /etc/traefik/traefik.yml

# Install Composer & PHP
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install -y php8.1
sudo apt install -y php-xml php-curl zip unzip docker-compose
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
sudo systemctl stop apache2
sudo systemctl disable apache2

# Clone megacorp-proxy
git clone https://github.com/mi-pacman/megacorp-proxy /home/terraform


############################
###PERSONAL_CUSTOMIZATION###
############################

sudo cp /vagrant/scripts/update_motd.sh /usr/bin/update_motd.sh  # Copy MOTD script to machine

chmod 775 /usr/bin/update_motd.sh  # Set permissions on MOTD script

sudo sed -i 's;session    optional     pam_motd.so  motd=/etd/motd;#session    optional     pam_motd.so  motd=/etc/motd;g' /etc/pam.d/sshd  # Set PAM to execute script upon each new session

sudo sed -i 's;session    optional     pam_motd.so noupdate;#session    optional     pam_motd.so noupdate;g' /etc/pam.d/sshd  # Prevent MOTD from showing twice

sudo printf 'session   optional   pam_exec.so   stdout /usr/bin/update_motd.sh\nsession   optional   pam_motd.so   motd=/etc/motd' >> /etc/pam.d/sshd  # Set PAM to execute script upon each new session



