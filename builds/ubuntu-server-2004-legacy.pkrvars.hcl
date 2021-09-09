communicator_type     = "ssh"
communicator_username = "administrator"
communicator_password = "VMware123!"

content_library_name = "ubuntu-server-20.04"
vm_name              = "packer-ubuntu-server-20.04"
guest_os_type        = "ubuntu64Guest"
hw_firmware          = "bios"

boot_wait    = "12s"
boot_command = [
  "<wait2s><enter><wait><esc><wait><enter>",
  "/install/vmlinuz",
  " initrd=/install/initrd.gz<wait>",
  " auto-install/enable=true",
  " debconf/priority=critical",
  " url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg",
  " -- <wait>",
  "<enter><wait>"
]

iso_installer = "[VRDS00] /ISO/Ubuntu/ubuntu-20.04.1-legacy-server-amd64.iso"
iso_vmtools   = "[] /vmimages/tools-isoimages/linux.iso"

http_directory = "config/ubuntu-server-20.04-legacy"

config_files = []

script_files = [
  "scripts/debian/install-update.sh",
  "scripts/debian/install-vmtools.sh",
]
