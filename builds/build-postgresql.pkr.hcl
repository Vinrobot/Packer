build {
  name = "postgresql"

  source "source.vsphere-clone.generic" {
    name         = "centos-server-8-pgsql"
    vm_name      = "packer-centos-server-8-pgsql14"
    template     = "packer-centos-server-8"
    communicator = "ssh"
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; echo '${var.communicator_password}' | {{ .Vars }} sudo -S -E '{{ .Path }}'"
    scripts = [
      "scripts/centos/install-postgresql.sh",
      "scripts/centos/sysprep.sh",
    ]
  }

  post-processor "manifest" {
    output     = "manifests/${build.name}.${source.type}.${source.name}.json"
    strip_path = false
    strip_time = false
  }
}
