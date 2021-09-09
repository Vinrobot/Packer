communicator_type     = "ssh"
communicator_username = "administrator"
communicator_password = "VMware123!"

content_library_name = "centos-server-8"
vm_name              = "packer-centos-server-8"
guest_os_type        = "centos8_64Guest"
hw_firmware          = "bios"

boot_wait    = "15s"
boot_command = [
  "<up><wait><tab><wait>",
  " inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg",
#  " inst.text inst.ks=hd:fd0:/ks.cfg",
  "<enter><wait>"
]

iso_installer = "[VRDS00] /ISO/CentOS/CentOS-8.4.2105-x86_64-dvd1.iso"
iso_vmtools   = "[] /vmimages/tools-isoimages/linux.iso"

http_directory = "config/centos-server-8"

config_files = [
#  "config/centos-server-8/ks.cfg"
]

script_files = [
  "scripts/centos/install-update.sh",
  "scripts/centos/install-vmtools.sh",
]
