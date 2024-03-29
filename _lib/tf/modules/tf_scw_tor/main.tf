data "scaleway_instance_image" "debian_stretch" {
  architecture = "x86_64"
  name         = "Debian Stretch"
}

resource "scaleway_instance_security_group" "sg" {
  count       = var.instance_count
  name        = "tor-${var.role}-${count.index}"
  description = "tor ${var.role} securtiy group ${count.index}"
  stateful    = false
}

resource "scaleway_instance_server" "server" {
  count             = var.instance_count
  name              = "tor-${var.role}-${count.index}"
  image             = data.scaleway_instance_image.debian_stretch.id
  boot_type         = "bootscript"
  type              = "VC1S"
  enable_dynamic_ip = true
  security_group_id = element(scaleway_instance_security_group.sg.*.id, count.index)

  lifecycle {
    ignore_changes = [
      image,
      user_data,
    ]
  }

  provisioner "local-exec" {
    command = "mkdir -p inventory/ && echo ${self.public_ip} ${var.role} ${count.index} >> inventory/${var.role}"
  }
}
