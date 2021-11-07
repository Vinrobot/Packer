build {
  name = "base"

  sources = [
    "source.vsphere-iso.windows-server-2019-core",
    "source.vsphere-iso.windows-server-2019-desktop",
  ]

  provisioner "powershell" {
    scripts = [
      "scripts/windows/disable-tls.ps1",
      "scripts/windows/set-temp.ps1",
      "scripts/windows/install-chocolatey.ps1",
    ]
  }

  post-processor "manifest" {
    output     = "manifests/${build.name}.${source.type}.${source.name}.json"
    strip_path = false
    strip_time = false
  }
}

build {
  name = "base"

  sources = [
    "source.vsphere-iso.debian-server-11",
    "source.vsphere-iso.ubuntu-server-2004",
    "source.vsphere-iso.ubuntu-server-2004-legacy",
  ]

  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    execute_command  = "chmod +x {{ .Path }}; echo '${var.communicator_password}' | {{ .Vars }} sudo -S -E '{{ .Path }}'"
    scripts = [
      "scripts/debian/install-update.sh",
      "scripts/debian/install-vmtools.sh",
    ]
  }

  post-processor "manifest" {
    output     = "manifests/${build.name}.${source.type}.${source.name}.json"
    strip_path = false
    strip_time = false
  }
}

build {
  name = "base"

  sources = [
    "source.vsphere-iso.centos-server-8",
  ]

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; echo '${var.communicator_password}' | {{ .Vars }} sudo -S -E '{{ .Path }}'"
    scripts = [
      "scripts/centos/install-update.sh",
      "scripts/centos/install-vmtools.sh",
    ]
  }

  post-processor "manifest" {
    output     = "manifests/${build.name}.${source.type}.${source.name}.json"
    strip_path = false
    strip_time = false
  }
}
