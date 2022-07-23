#!/bin/bash
set -x

##########################
###SYSTEM_CONFIGURATION###
##########################

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


###################################
###WEB_APPLICATION_CONFIGURATION###
###################################
sudo mkdir /terraform
sudo git clone https://github.com/mi-pacman/megacorp-proxy /terraform/megacorp-proxy
sudo chown -R terraform:terraform /terraform

# Configure traefik proxy
sudo mkdir /etc/traefik
sudo cp /tmp/traefik.yml /etc/traefik/traefik.yml

# Install Composer & PHP
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install -y php8.1
sudo apt install -y php-xml php-curl zip unzip docker-compose
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
sudo systemctl stop apache2
sudo systemctl disable apache2


############################
###MOTD_CUSTOMIZATION###
############################
sudo cp /tmp/update_motd.sh /usr/bin/update_motd.sh  # Copy MOTD script to machine
sudo chmod 775 /usr/bin/update_motd.sh  # Set permissions on MOTD script
sudo sed -i 's;session    optional     pam_motd.so  motd=/etd/motd;#session    optional     pam_motd.so  motd=/etc/motd;g' /etc/pam.d/sshd  # Set PAM to execute script upon each new session
sudo sed -i 's;session    optional     pam_motd.so noupdate;#session    optional     pam_motd.so noupdate;g' /etc/pam.d/sshd  # Prevent MOTD from showing twice
sudo sed -i 's;session    optional     pam_motd.so  motd=/run/motd.dynamic;#session    optional     pam_motd.so  motd=/run/motd.dynamic;g' /etc/pam.d/sshd  # Prevent MOTD from showing twice
printf 'session   optional   pam_exec.so   stdout /usr/bin/update_motd.sh\nsession   optional   pam_motd.so   motd=/etc/motd' | sudo tee -a /etc/pam.d/sshd  # Set PAM to execute script upon each new session


#######################
###VIM_CONFIGURATION###
#######################
git clone --depth=1 https://github.com/amix/vimrc.git /opt/vim_runtime
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_parameterized.sh /opt/vim_runtime --all


######################
###ZSH_CONGIRUATION###
######################
pacman -S --noconfirm zsh  # Download Zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git /home/terraform/.oh-my-zsh  # Clone zsh config repo
cp /tmp/zshrc /home/terraform/.zshrc  # Copy over template .zshrc file
cp /tmp/aliases.zsh /home/terraform/.oh-my-zsh/custom/aliases.zsh  # Copy over custom aliases
usermod --shell /bin/zsh terraform  # Change user vagrants default shell