build {
  name = "docker"

  source "source.vsphere-clone.generic" {
    name         = "windows-server-2019-core-docker"
    vm_name      = "packer-windows-server-2019-standard-core-docker"
    template     = "packer-windows-server-2019-standard-core"
    communicator = "winrm"
  }

  source "source.vsphere-clone.generic" {
    name         = "windows-server-2019-desktop-docker"
    vm_name      = "packer-windows-server-2019-standard-desktop-docker"
    template     = "packer-windows-server-2019-standard-desktop"
    communicator = "winrm"
  }

  provisioner "powershell" {
    scripts = [
      "scripts/windows/install-docker.ps1",
    ]
  }

  post-processor "manifest" {
    output     = "manifests/${build.name}.${source.type}.${source.name}.json"
    strip_path = false
    strip_time = false
  }
}

build {
  name = "docker"

  source "source.vsphere-clone.generic" {
    name         = "debian-server-11-docker"
    vm_name      = "packer-debian-server-11-docker"
    template     = "packer-debian-server-11"
    communicator = "ssh"
  }

  source "source.vsphere-clone.generic" {
    name         = "centos-server-8-docker"
    vm_name      = "packer-centos-server-8-docker"
    template     = "packer-centos-server-8"
    communicator = "ssh"
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; echo '${var.communicator_password}' | {{ .Vars }} sudo -S -E '{{ .Path }}'"
    scripts = [
      "scripts/linux/get-docker.sh",
      "scripts/linux/setup-docker.sh",
    ]
  }

  post-processor "manifest" {
    output     = "manifests/${build.name}.${source.type}.${source.name}.json"
    strip_path = false
    strip_time = false
  }
}
