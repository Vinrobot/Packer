source "vsphere-iso" "windows-server-2019-desktop" {
  create_snapshot = var.create_snapshot

  # Boot/Run Configuration
  boot_wait = "3s"
  boot_command = [
    "<spacebar>"
  ]
  boot_order = var.boot_order

  # Floppy configuration
  floppy_files = [
    "config/windows-server-2019-desktop",
    "drivers/pvscsi",
    "scripts/windows"
  ]

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
  vm_name   = "packer-windows-server-2019-standard-desktop"
  folder    = var.vsphere_folder
  cluster   = var.vsphere_cluster
  datastore = var.vsphere_datastore

  # Wait Configuration
  ip_wait_timeout = var.ip_wait_timeout

  # CDRom Configuration
  iso_paths = [
    "[VRDS00] /ISO/Windows/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso",
    "[] /vmimages/tools-isoimages/windows.iso"
  ]

  # Create Configuration
  vm_version           = var.vm_version
  guest_os_type        = "windows2019srv_64Guest"
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
    #name    = Default to vm_name
    destroy = var.content_library_destroy_vm
    ovf     = var.content_library_as_ovf
  }

  # Communicator Configuration
  communicator = "winrm"

  # Communicator (WinRM) Configuration
  winrm_username = var.communicator_username
  winrm_password = var.communicator_password
  winrm_timeout  = var.communicator_timeout
  winrm_insecure = true
  winrm_use_ssl  = true
  winrm_use_ntlm = true
}
