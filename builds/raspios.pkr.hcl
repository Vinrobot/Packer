
source "arm-image" "raspios" {
  iso_checksum    = "sha256:24bf4ded19372c6ae8a2633a207cd861c86237b533778fc8a04242c53fcbcbd4"
  iso_url         = "https://downloads.raspberrypi.com/raspios_lite_arm64/images/raspios_lite_arm64-2024-10-28/2024-10-22-raspios-bookworm-arm64-lite.img.xz"
  output_filename = "outputs/raspios.img"
}

build {
  sources = [
    "source.arm-image.raspios",
  ]

  provisioner "shell" {
    inline = [
      "apt-get update",
      "apt-get upgrade -y",
    ]
  }
}
