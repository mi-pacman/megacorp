variable "autounattend" {
  type    = string
  default = "../answer_files/2022/Autounattend.xml"
}

variable "disk_size" {
  type    = string
  default = "61440"
}

variable "disk_type_id" {
  type    = string
  default = "1"
}

variable "headless" {
  type    = string
  default = "false"
}

variable "iso_checksum" {
  type    = string
  default = "md5:e7908933449613edc97e1b11180429d1"
}

variable "iso_url" {
  type    = string
  default = "/home/dedsec/Vagrant/Windows10/SERVER_EVAL_x64FRE_en-us.iso"
}

variable "manually_download_iso_from" {
  type    = string
  default = "https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2022"
}

variable "memory" {
  type    = string
  default = "2048"
}

variable "restart_timeout" {
  type    = string
  default = "5m"
}

variable "virtio_win_iso" {
  type    = string
  default = "/home/dedsec/Downloads/virtio-win-0.1.225.iso"
}

variable "winrm_timeout" {
  type    = string
  default = "5m"
}

variable "winrm_username" {
  type    = string
  default = "User"
}

variable "winrm_password" {
  type      = string
  default   = "changeme"
  sensitive = true
}

