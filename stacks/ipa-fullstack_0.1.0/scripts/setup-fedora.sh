#!/bin/bash
set -x

##########################
###SYSTEM_CONFIGURATION###
##########################

# Install necessary dependencies
sudo dnf upgrade -y
sudo dnf install -y tmux curl wget git vim apt-transport-https ca-certificates

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

# Copy traefik proxy configuration
sudo mkdir /etc/traefik
sudo cp /tmp/traefik.yml /etc/traefik/traefik.yml


########################
###MOTD_CUSTOMIZATION###
########################
sudo cp /tmp/update_motd.sh /usr/bin/update_motd.sh  # Copy MOTD script to machine
sudo chmod 775 /usr/bin/update_motd.sh  # Set permissions on MOTD script
sudo sed -i 's;session    optional     pam_motd.so;#session    optional     pam_motd.so;g' /etc/pam.d/sshd  # Comment out existing PAM MOTD entry
printf 'session   optional   pam_exec.so   stdout /usr/bin/update_motd.sh\nsession   optional   pam_motd.so   motd=/etc/motd' | sudo tee -a /etc/pam.d/sshd  # Set PAM to execute script upon each new session


#######################
###VIM_CONFIGURATION###
#######################
sudo git clone --depth=1 https://github.com/amix/vimrc.git /opt/vim_runtime
sudo git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sudo sh ~/.vim_runtime/install_awesome_parameterized.sh /opt/vim_runtime --all


######################
###ZSH_CONGIRUATION###
######################
sudo dnf install -y zsh  # Download Zsh
sudo git clone https://github.com/ohmyzsh/ohmyzsh.git /home/terraform/.oh-my-zsh  # Clone zsh config repo
sudo cp /tmp/zshrc /home/terraform/.zshrc  # Copy over template .zshrc file
sudo cp /tmp/aliases.zsh /home/terraform/.oh-my-zsh/custom/aliases.zsh  # Copy over custom aliases
sudo usermod --shell /bin/zsh terraform  # Change user terraforms default shell
sudo chown -R terraform:terraform /home/terraform/.oh-my-zsh /home/terraform/.zshrc


#######################
###IPA_CONFIGURATION###
#######################

sudo yum install -y freeipa-server freeipa-server-dns nfs-utils
sudo reboot
sudo sed -i 's/preserve_hostname: false/preserve_hostname: true/g' /etc/cloud/cloud.cfg  # Set hostname to persist during reboots
