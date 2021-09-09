communicator_type     = "winrm"
communicator_username = "administrator"
communicator_password = "VMware123!"

content_library_name = "windows-server-2019-standard-core"
vm_name              = "packer-windows-server-2019-standard-core"
guest_os_type        = "windows2019srv_64Guest"

boot_wait    = "3s"
boot_command = [
  "<spacebar>"
]

iso_installer = "[VRDS00] /ISO/Windows/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"
iso_vmtools   = "[] /vmimages/tools-isoimages/windows.iso"

config_files = [
  "config/windows-server-2019-core",
  "drivers/pvscsi",
  "scripts/windows"
]

script_files = [
  "scripts/windows/disable-tls.ps1",
  "scripts/windows/set-temp.ps1",
  "scripts/windows/install-chocolatey.ps1"
]
