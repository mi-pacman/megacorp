terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

provider "libvirt" {
  ## Configuration options
  uri = "qemu:///system"
  #alias = "server2"
  #uri   = "qemu+ssh://root@192.168.100.10/system"
}

# Defining VM Volume
resource "libvirt_volume" "win22-qcow2" {
  name = "win22.qcow2"
  pool = "default" # List storage pools using virsh pool-list
  source = "/home/dedsec/Git/megacorp/Packer/KVM/Windows/CORE/windows_2022-qemu/WindowsServer2022.qcow2"
  format = "qcow2"
}

# Define KVM domain to create
resource "libvirt_domain" "win22" {
  name   = "win22"
  memory = "2048"
  vcpu   = 2

  network_interface {
    network_name = "default" # List networks with virsh net-list
  }

  disk {
    volume_id = "${libvirt_volume.win22-qcow2.id}"
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}

# Output Server IP
output "ip" {
  value = "${libvirt_domain.win22.network_interface.0.addresses.0}"
}
