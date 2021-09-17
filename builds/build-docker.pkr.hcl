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
