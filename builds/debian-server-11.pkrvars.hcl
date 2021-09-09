communicator_type     = "ssh"
communicator_username = "administrator"
communicator_password = "VMware123!"

content_library_name = "debian-server-11"
vm_name              = "packer-debian-server-11"
guest_os_type        = "debian10_64Guest"
hw_firmware          = "bios"

boot_wait    = "5s"
boot_command = [
  "<wait3s><esc><wait3s>",
  "/install.amd/vmlinuz",
  " initrd=/install.amd/initrd.gz<wait>",
  " auto-install/enable=true",
  " debconf/priority=critical",
  " url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg",
  " -- <wait>",
  "<enter><wait>"
]

iso_installer = "[VRDS00] /ISO/Debian/debian-11.0.0-amd64-netinst.iso"
iso_vmtools   = "[] /vmimages/tools-isoimages/linux.iso"

http_directory = "config/debian-server-11"

config_files = []

script_files = [
  "scripts/debian/install-update.sh",
  "scripts/debian/install-vmtools.sh",
]
