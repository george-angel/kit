variable "role" {}
variable "instance_count" {}

data "scaleway_image" "debian-stretch" {
  architecture = "x86_64"
  name         = "Debian Stretch"
}

data "scaleway_bootscript" "mainline-413" {
  architecture = "x86_64"
  name_filter  = "x86_64 mainline 4.13"
}

resource "scaleway_security_group" "sg" {
  count       = "${var.instance_count}"
  name        = "tor-${var.role}-${count.index}"
  description = "tor ${var.role} securtiy group ${count.index}"
}

resource "scaleway_server" "server" {
  count               = "${var.instance_count}"
  name                = "tor-${var.role}-${count.index}"
  image               = "${data.scaleway_image.debian-stretch.id}"
  bootscript          = "${data.scaleway_bootscript.mainline-413.id}"
  type                = "VC1S"
  dynamic_ip_required = true
  security_group      = "${element(scaleway_security_group.sg.*.id, count.index)}"

  provisioner "local-exec" {
    command = "mkdir -p inventory/ && echo ${self.public_ip} ${var.role} ${count.index} >> inventory/${var.role}"
  }
}
