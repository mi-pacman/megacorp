variable "region" {
  type    = string
  default = "ap-southeast-2"
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }


# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioners and post-processors on a
# source.
source "amazon-ebs" "controller" {
  ami_name      = "Cloud-Controller-${local.timestamp}"
  instance_type = "t2.micro"
  region        = var.region
  source_ami_filter {
    filters = {
      name                = "Fedora-Cloud-Base-34-1.2.x86_64-hvm-ap-southeast-2-standard*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["125523088429"]
  }
  ssh_username = "fedora"
}

# a build block invokes sources and runs provisioning steps on them.
build {
  sources = ["source.amazon-ebs.controller"]
  provisioner "file" {
    source      = "../keys/tf-packer.pub"
    destination = "/tmp/tf-packer.pub"
  }
  provisioner "file" {
    source      = "../scripts/update_motd.sh"
    destination = "/tmp/update_motd.sh"
  }
  provisioner "file" {
    source      = "../configs/traefik.yml"
    destination = "/tmp/traefik.yml"
  }
  provisioner "file" {
    source      = "../configs/zshrc"
    destination = "/tmp/zshrc"
  }
  provisioner "file" {
    source      = "../configs/aliases.zsh"
    destination = "/tmp/aliases.zsh"
  }
  provisioner "shell" {
    script = "../scripts/setup-fedora.sh"
  }
}
