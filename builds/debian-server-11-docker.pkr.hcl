source "vsphere-clone" "debian-server-11-docker" {
  # Connection Configuration
  vcenter_server      = var.vsphere_server
  username            = var.vsphere_username
  password            = var.vsphere_password
  insecure_connection = var.vsphere_insecure
  datacenter          = var.vsphere_datacenter

  # Location Configuration
  vm_name   = "packer-debian-server-11-docker"
  folder    = var.vsphere_folder
  cluster   = var.vsphere_cluster
  datastore = var.vsphere_datastore

  # Wait Configuration
  ip_wait_timeout = var.ip_wait_timeout

  # Clone Configuration
  template = "packer-debian-server-11"
  network  = var.vsphere_portgroup
  notes    = var.notes

  # Content Library Import Configuration
  content_library_destination {
    library = var.content_library_destination
    name    = "debian-server-11-docker"
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
