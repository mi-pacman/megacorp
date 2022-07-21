# Dockerfile that installs Packer

FROM alpine:edge

RUN apk update && apk upgrade && apk add curl openssh-server sudo 

RUN ssh-keygen -A 

RUN release=`curl -s https://api.github.com/repos/hashicorp/packer/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'` && wget https://releases.hashicorp.com/packer/${release}/packer_${release}_linux_amd64.zip && unzip packer_${release}_linux_amd64.zip && rm packer_${release}_linux_amd64.zip

RUN mv packer /usr/bin/packer

RUN apk del curl

RUN sed -i 's/#PermitRootLogin\sprohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

RUN echo 'root:changeme' | chpasswd

RUN mkdir /root/images

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
