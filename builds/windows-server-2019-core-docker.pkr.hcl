source "vsphere-clone" "windows-server-2019-core-docker" {
  # Connection Configuration
  vcenter_server      = var.vsphere_server
  username            = var.vsphere_username
  password            = var.vsphere_password
  insecure_connection = var.vsphere_insecure
  datacenter          = var.vsphere_datacenter

  # Location Configuration
  vm_name   = "packer-windows-server-2019-standard-core-docker"
  folder    = var.vsphere_folder
  cluster   = var.vsphere_cluster
  datastore = var.vsphere_datastore

  # Wait Configuration
  ip_wait_timeout = var.ip_wait_timeout

  # Clone Configuration
  template = "packer-windows-server-2019-standard-core"
  network  = var.vsphere_portgroup
  notes    = var.notes

  # Content Library Import Configuration
  content_library_destination {
    library = var.content_library_destination
    name    = "windows-server-2019-standard-core-docker"
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
