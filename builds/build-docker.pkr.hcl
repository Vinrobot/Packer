build {
  name = "docker"

  sources = [
    "source.vsphere-clone.windows-server-2019-core-docker"
  ]

  provisioner "powershell" {
    scripts = [
      "scripts/windows/install-docker.ps1"
    ]
  }

  post-processor "manifest" {
    output     = "manifests/docker.${source.type}.${source.name}.json"
    strip_path = false
    strip_time = false
  }
}

build {
  name = "docker"

  sources = [
    "source.vsphere-clone.debian-server-11-docker"
  ]

  provisioner "shell" {
    execute_command  = "chmod +x {{ .Path }}; echo '${var.communicator_password}' | {{ .Vars }} sudo -S -E '{{ .Path }}'"
    scripts          = [
      "scripts/linux/get-docker.sh",
      "scripts/linux/setup-docker.sh"
    ]
  }

  post-processor "manifest" {
    output     = "manifests/docker.${source.type}.${source.name}.json"
    strip_path = false
    strip_time = false
  }
}
