#!/bin/bash

##########################
###SYSTEM_CONFIGURATION###
##########################
timedatectl set-timezone Australia/Adelaide  # Set timezone to Adelaide
systemctl enable systemd-timesyncd  # Enable timesync daemon on boot
echo "vagrant:changeme" | chpasswd  # Change vagrants password to changeme


######################
###PACKAGE_INSTALLS###
######################
pacman -Sy  # Update repos
pacman -S --noconfirm git # Installing Git
pacman -S --noconfirm docker docker-compose  # Install docker and compose


######################
###ZSH_CONGIRUATION###
######################
pacman -S --noconfirm zsh  # Download Zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git /home/vagrant/.oh-my-zsh  # Clone zsh config repo
cp /vagrant/configs/zshrc /home/vagrant/.zshrc  # Copy over template .zshrc file
cp /vagrant/configs/aliases.zsh /home/vagrant/.oh-my-zsh/custom/aliases.zsh  # Copy over custom aliases
usermod --shell /bin/zsh vagrant  # Change user vagrants default shell


#######################
###VIM_CONFIGURATION###
#######################
git clone --depth=1 https://github.com/amix/vimrc.git /opt/vim_runtime
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_parameterized.sh /opt/vim_runtime --all


##########################
###DOCKER_CONFIGURATION###
##########################
systemctl enable docker && systemctl start docker  # Enable and start docker daemon on boot
docker pull midockerdb/terraform-controller:0.1.3  # Pull custom terraform container image
docker pull midockerdb/packer-controller:0.1.3  # Pull custom packer container image


#########################
###CLOUD_CONFIGURATION###
#########################
mkdir /home/vagrant/.aws
printf '[default]\naws_access_key_id = <ACCESS_KEY>\naws_secret_access_key = <SECRET_KEY>' > .aws/credentials
chown -R vagrant:vagrant /home/vagrant


############################
###PERSONAL_CUSTOMIZATION###
############################

cp /vagrant/scripts/update_motd.sh /usr/bin/update_motd.sh  # Copy MOTD script to machine

chmod 775 /usr/bin/update_motd.sh  # Set permissions on MOTD script

printf 'session   optional   pam_exec.so   stdout /usr/bin/update_motd.sh\nsession   optional   pam_motd.so   motd=/etc/motd' >> /etc/pam.d/sshd  # Set PAM to execute script upon each new session

sed -i 's/session    optional   pam_motd.so/#session    optional   pam_motd.so/g' /etc/pam.d/system-login  # Prevent MOTD from multiplying upon each ssh session

sed -i 's/#Color/Color\nILoveCandy/g' /etc/pacman.conf  # For enabling color and pacman-styled pacman
