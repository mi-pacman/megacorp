# Dockerfile that installs Terraform

FROM alpine:edge

RUN apk update && apk upgrade && apk add curl openssh-server sudo 

RUN ssh-keygen -A

RUN release=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1'` && wget https://releases.hashicorp.com/terraform/${release}/terraform_${release}_linux_amd64.zip && unzip terraform_${release}_linux_amd64.zip && rm terraform_${release}_linux_amd64.zip

RUN mv terraform /usr/bin/terraform 

RUN apk del curl

RUN sed -i 's/#PermitRootLogin\sprohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config                                                                                     
RUN echo 'root:changeme' | chpasswd

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
