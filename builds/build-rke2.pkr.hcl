build {
  name = "rke2"

  source "source.vsphere-clone.generic" {
    name         = "centos-server-8-rke2"
    vm_name      = "packer-centos-server-8-rke2"
    template     = "packer-centos-server-8"
    communicator = "ssh"
  }

  # Install RKE2 Agent
  provisioner "shell" {
    environment_vars = ["INSTALL_RKE2_TYPE=agent"]
    execute_command  = "chmod +x {{ .Path }}; echo '${var.communicator_password}' | {{ .Vars }} sudo -S -E '{{ .Path }}'"
    scripts = [
      "scripts/linux/get-rke2.sh",
    ]
  }

  # Install RKE2 Server
  provisioner "shell" {
    environment_vars = ["INSTALL_RKE2_TYPE=server"]
    execute_command  = "chmod +x {{ .Path }}; echo '${var.communicator_password}' | {{ .Vars }} sudo -S -E '{{ .Path }}'"
    scripts = [
      "scripts/linux/get-rke2.sh",
    ]
  }

  provisioner "shell" {
    environment_vars = [
      "USE_SUDO=false",
      "VERIFY_SIGNATURES=true",
      "PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin",
    ]
    execute_command = "chmod +x {{ .Path }}; echo '${var.communicator_password}' | sudo -S -E bash -c '{{ .Vars }} \"{{ .Path }}\"'"
    scripts = [
      "scripts/linux/get_helm.sh",
      "scripts/centos/sysprep.sh",
    ]
  }

  post-processor "manifest" {
    output     = "manifests/rke2.${source.type}.${source.name}.json"
    strip_path = false
    strip_time = false
  }
}
