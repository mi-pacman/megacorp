##########################
###Terraform Controller###
##########################
alias poweron-tc='sudo docker run -d \
-v /home/vagrant/.aws/credentials:/root/.aws/credentials:ro \
-v /vagrant/cloud/instances:/root/instances \
-p 2222:22 \
-h terraform-controller \
--name terraform-controller \
midockerdb/terraform-controller:0.1.3'

alias connect-tc='ssh -p 2222 root@localhost'

alias poweroff-tc='sudo docker stop terraform-controller && sudo docker rm terraform-controller'

#######################
###Packer Controller###
#######################
alias poweron-pc='sudo docker run -d \
-v /home/vagrant/.aws/credentials:/root/.aws/credentials:ro \
-v /vagrant/cloud/images:/root/images:ro \
-v /vagrant/cloud/keys:/root/keys:ro \
-v /vagrant/configs:/root/configs:ro \
-v /vagrant/scripts:/root/scripts:ro \
-p 2223:22 \
-h packerController \
--name packer-controller \
midockerdb/packer-controller:0.1.3'

alias connect-pc='ssh -p 2223 root@localhost'

alias poweroff-pc='sudo docker stop packer-controller && sudo docker rm packer-controller'

#Generate SSH Key
alias generate-key='ssh-keygen -t ed25519 -f /vagrant/cloud/keys/tf-packer'

#Fetch terraform public_ip output from container
alias terraformipraw='sudo docker exec -it terraform-controller terraform output --state /root/instances/terraform.tfstate public_ip'
alias terraformip="terraformipraw | sed 's/\"//g'"  # Removes "" from output
