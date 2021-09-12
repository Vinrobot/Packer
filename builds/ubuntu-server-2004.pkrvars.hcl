communicator_type     = "ssh"
communicator_username = "administrator"
communicator_password = "VMware123!"

content_library_name = "ubuntu-server-20.04"
vm_name              = "packer-ubuntu-server-20.04"
guest_os_type        = "ubuntu64Guest"
hw_firmware          = "bios"

boot_wait    = "5s"
boot_command = [
  "<enter><wait><enter><wait><f6><wait><esc><wait>",
  "<wait15s>",
  " autoinstall ds=nocloud-net;",
  "seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
  "<enter><wait>"
]

iso_installer = "[VRDS00] /ISO/Ubuntu/ubuntu-20.04.2-live-server-amd64.iso"
iso_vmtools   = "[] /vmimages/tools-isoimages/linux.iso"

http_directory = "config/ubuntu-server-20.04"

config_files = []

script_files = [
  "scripts/debian/install-update.sh",
  "scripts/debian/install-vmtools.sh",
]
