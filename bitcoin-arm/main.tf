variable "role" {
  default = "bitcoin"
}

variable "instance_count" {
  default = 1
}

data "scaleway_image" "debian-stretch" {
  architecture = "x86_64"
  name         = "Debian Stretch"
}

resource "scaleway_security_group" "sg" {
  count       = "${var.instance_count}"
  name        = "${var.role}-${count.index}"
  description = "${var.role} ${count.index}"
}

resource "scaleway_server" "server" {
  count               = "${var.instance_count}"
  name                = "${var.role}-${count.index}"
  image               = "${data.scaleway_image.debian-stretch.id}"
  type                = "C2S"
  dynamic_ip_required = true
  enable_ipv6         = true
  security_group      = "${element(scaleway_security_group.sg.*.id, count.index)}"

  volume {
    size_in_gb = 150
    type       = "l_ssd"
  }

  volume {
    size_in_gb = 150
    type       = "l_ssd"
  }

  provisioner "local-exec" {
    command = "mkdir -p inventory/ && echo ${self.public_ip} ${var.role} ${count.index} > inventory/${var.role}"
  }
}
