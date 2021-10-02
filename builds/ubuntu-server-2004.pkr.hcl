source "vsphere-iso" "ubuntu-server-2004" {
  # Boot/Run Configuration
  boot_wait = "3s"
  boot_command = [
    "<esc><esc><esc>",
    "linux /casper/vmlinuz",
    " \"ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/\"",
    " autoinstall ---<enter>",
    "initrd /casper/initrd<enter>",
    "boot<enter>"
  ]
  boot_order = var.boot_order

  # HTTP Directory Configuration
  http_directory = "config/ubuntu-server-20.04"
  http_port_min  = var.http_port_min
  http_port_max  = var.http_port_max

  # Floppy configuration
  floppy_files = []

  # Connection Configuration
  vcenter_server      = var.vsphere_server
  username            = var.vsphere_username
  password            = var.vsphere_password
  insecure_connection = var.vsphere_insecure
  datacenter          = var.vsphere_datacenter

  # Hardware Configuration
  CPUs            = var.hw_cpus
  RAM             = var.hw_ram
  RAM_reserve_all = var.hw_ram_reserve_all
  firmware        = var.hw_firmware

  # Location Configuration
  vm_name   = "packer-ubuntu-server-20.04"
  folder    = var.vsphere_folder
  cluster   = var.vsphere_cluster
  datastore = var.vsphere_datastore

  # Wait Configuration
  ip_wait_timeout = var.ip_wait_timeout

  # CDRom Configuration
  iso_paths = [
    "[VRDS00] /ISO/Ubuntu/ubuntu-20.04.2-live-server-amd64.iso"
  ]

  # Create Configuration
  vm_version           = var.vm_version
  guest_os_type        = "ubuntu64Guest"
  notes                = var.notes
  disk_controller_type = var.disk_controller_type
  network_adapters {
    network      = var.vsphere_portgroup
    network_card = var.vsphere_network_card
  }
  storage {
    disk_size             = var.disk_size
    disk_thin_provisioned = var.disk_thin_provisioned
  }

  # Content Library Import Configuration
  content_library_destination {
    library = var.content_library_destination
    name    = "ubuntu-server-20.04"
    destroy = var.content_library_destroy_vm
    ovf     = var.content_library_as_ovf
  }

  # Communicator Configuration
  communicator = "ssh"

  # Communicator (SSH) Configuration
  ssh_username           = var.communicator_username
  ssh_password           = var.communicator_password
  ssh_timeout            = var.communicator_timeout
  ssh_handshake_attempts = var.ssh_handshake_attempts
}
