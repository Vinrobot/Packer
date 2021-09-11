communicator_type     = "winrm"
communicator_username = "administrator"
communicator_password = "VMware123!"

content_library_name = "windows-server-2019-standard-core-docker"
vm_template          = "packer-windows-server-2019-standard-core"
vm_name              = "packer-windows-server-2019-standard-core-docker"

config_files = []

script_files = [
  "scripts/windows/install-docker.ps1"
]
