variable "vsphere_server" {
  type = string
}
variable "vsphere_username" {
  type      = string
  sensitive = true
}
variable "vsphere_password" {
  type      = string
  sensitive = true
}
variable "vsphere_insecure" {
  type    = bool
  default = false
}

variable "vsphere_datacenter" {
  type = string
}
variable "vsphere_cluster" {
  type = string
}
variable "vsphere_datastore" {
  type = string
}
variable "vsphere_folder" {
  type = string
}
variable "vsphere_portgroup" {
  type    = string
  default = "VM Network"
}
variable "vsphere_network_card" {
  type    = string
  default = "vmxnet3"
}

variable "communicator_type" {
  type    = string
  default = "ssh"
}
variable "communicator_username" {
  type      = string
  sensitive = true
  default   = "administrator"
}
variable "communicator_password" {
  type      = string
  sensitive = true
  default   = "VMware123!"
}
variable "communicator_timeout" {
  type    = string
  default = "30m"
}

variable "ssh_handshake_attempts" {
  type    = number
  default = 20
}

variable "content_library_destination" {
  type = string
}
variable "content_library_name" {
  type = string
}
variable "content_library_destroy_vm" {
  type    = bool
  default = true
}
variable "content_library_as_ovf" {
  type    = bool
  default = true
}

variable "vm_version" {
  type    = number
  default = 17
}
variable "vm_name" {
  type = string
}

variable "hw_firmware" {
  type    = string
  default = "efi"
}
variable "hw_cpus" {
  type    = number
  default = 2
}
variable "hw_ram" {
  type    = number
  default = 4096
}
variable "hw_ram_reserve_all" {
  type    = bool
  default = true
}

variable "notes" {
  type    = string
  default = "Built with Packer"
}

variable "disk_controller_type" {
  type    = list(string)
  default = ["pvscsi"]
}
variable "disk_thin_provisioned" {
  type    = bool
  default = true
}
variable "disk_size" {
  type    = number
  default = 61440
}

variable "boot_wait" {
  type = string
}
variable "boot_command" {
  type = list(string)
}
variable "boot_order" {
  type    = string
  default = "disk,cdrom"
}

variable "guest_os_type" {
  type = string
}

variable "ip_wait_timeout" {
  type    = string
  default = "1h"
}

variable "iso_installer" {
  type = string
}
variable "iso_vmtools" {
  type = string
}

variable "config_files" {
  type = list(string)
}
variable "script_files" {
  type = list(string)
}

variable "http_directory" {
  type    = string
  default = null
}
variable "http_port_min" {
  type    = number
  default = 8000
}
variable "http_port_max" {
  type    = number
  default = 9000
}
