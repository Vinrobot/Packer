source "vsphere-iso" "windows-server-2019-desktop" {
  # Boot/Run Configuration
  boot_wait    = var.boot_wait
  boot_command = var.boot_command
  boot_order   = var.boot_order

  # HTTP Directory Configuration
  http_directory = var.http_directory
  http_port_min  = var.http_port_min
  http_port_max  = var.http_port_max

  # Floppy configuration
  floppy_files = var.config_files

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
  vm_name   = var.vm_name
  folder    = var.vsphere_folder
  cluster   = var.vsphere_cluster
  datastore = var.vsphere_datastore

  # Wait Configuration
  ip_wait_timeout = var.ip_wait_timeout

  # CDRom Configuration
  iso_paths = [
    var.iso_installer,
    var.iso_vmtools
  ]

  # Create Configuration
  vm_version           = var.vm_version
  guest_os_type        = var.guest_os_type
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
    name    = var.content_library_name
    destroy = var.content_library_destroy_vm
    ovf     = var.content_library_as_ovf
  }

  # Communicator Configuration
  communicator = var.communicator_type

  # Communicator (SSH) Configuration
  ssh_username           = var.communicator_username
  ssh_password           = var.communicator_password
  ssh_timeout            = var.communicator_timeout
  ssh_handshake_attempts = var.ssh_handshake_attempts

  # Communicator (WinRM) Configuration
  winrm_username = var.communicator_username
  winrm_password = var.communicator_password
  winrm_timeout  = var.communicator_timeout
  winrm_insecure = true
  winrm_use_ssl  = true
  winrm_use_ntlm = true
}

build {
  sources = [
    "source.vsphere-iso.windows-server-2019-desktop"
  ]

  provisioner "powershell" {
    scripts = var.script_files
  }

  post-processor "manifest" {
    output     = "manifests/windows-server-2019-desktop.json"
    strip_path = false
    strip_time = false
  }
}
