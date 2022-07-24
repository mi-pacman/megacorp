#!/bin/bash
set -x

##########################
###SYSTEM_CONFIGURATION###
##########################

timedatectl set-timezone Australia/Adelaide  # Set timezone to Adelaide
# Install necessary dependencies
dnf upgrade -y
dnf install -y tmux curl wget vim apt-transport-https ca-certificates


########################
###MOTD_CUSTOMIZATION###
########################
cp /vagrant/scripts/update_motd.sh /usr/bin/update_motd.sh  # Copy MOTD script to machine
chmod 775 /usr/bin/update_motd.sh  # Set permissions on MOTD script
sed -i 's;session    optional     pam_motd.so;#session    optional     pam_motd.so;g' /etc/pam.d/sshd  # Comment out existing PAM MOTD entry
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
dnf install -y zsh  # Download Zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git /home/vagrant/.oh-my-zsh  # Clone zsh config repo
cp /vagrant/configs/zshrc /home/vagrant/.zshrc  # Copy over template .zshrc file
usermod --shell /bin/zsh vagrant  # Change user vagrants default shell


#######################
###IPA_CONFIGURATION###
#######################

yum install -y freeipa-server freeipa-server-dns nfs-utils  # Fetch IPA packages and dependencies
cp /vagrant/configs/hosts /etc/hosts  # Copy over hosts file template
printf 'ipa.example.local' > /etc/hostname  # Set generic host and domain name
sudo firewall-cmd --add-service=freeipa-ldap --add-service=freeipa-ldaps  # Open firewalls
sudo firewall-cmd --add-service=freeipa-ldap --add-service=freeipa-ldaps --permanent  # Open firewalls
sed -i 's;net.ipv6.conf.all.disable_ipv6 = 1;net.ipv6.conf.all.disable_ipv6 = 0\nnet.ipv6.conf.lo.disable_ipv6 = 0;g' /etc/sysctl.conf
reboot
