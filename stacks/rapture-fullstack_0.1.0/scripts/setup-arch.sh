#!/bin/bash

##########################
###SYSTEM_CONFIGURATION###
##########################
timedatectl set-timezone Australia/Adelaide  # Set timezone to Adelaide
echo "rapture" > /etc/hostname  # Change the hostname
systemctl enable systemd-timesyncd  # Enable timesync daemon on boot
echo "vagrant:changeme" | chpasswd  # Change vagrants password to changeme
cp /vagrant/configs/bash_aliases /home/vagrant/.bash_aliases

##########################
###DOCKER_CONFIGURATION###
##########################
#pacman -Sy  # Update repos
#pacman -S --noconfirm docker docker-compose  # Update repositories, install docker and compose
#systemctl enable docker && systemctl start docker  # Enable and start docker daemon on boot
#docker pull midockerdb/terraform-controller:0.1.3  # Pull custom terraform container image
#docker pull midockerdb/packer-controller:0.1.3  # Pull custom packer container image

#########################
###CLOUD_CONFIGURATION###
#########################
mkdir /home/vagrant/.aws
printf '[default]\naws_access_key_id = <ACCESS_KEY>\naws_secret_access_key = <SECRET_KEY>' > .aws/credentials
chown -R vagrant:vagrant /home/vagrant

############################
###PERSONAL_CUSTOMIZATION###
############################
cp /vagrant/scripts/update_motd.sh /usr/bin/update_motd.sh
#chmod 775 /usr/bin/update_motd.sh
#printf 'session   optional   pam_exec.so   stdout /usr/bin/update_motd.sh\nsession   optional   pam_motd.so   motd=/etc/motd' >> /etc/pam.d/sshd
reboot
