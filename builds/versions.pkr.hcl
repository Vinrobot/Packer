packer {
  required_version = ">= 1.7.8"

  required_plugins {
    vsphere = {
      version = ">= v1.0.1"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}
