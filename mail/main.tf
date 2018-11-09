variable "role" {
  default = "mail"
}

// Ubuntu Xenial (16.04 latest)
variable "old_image" {
  default = "75c28f52-6c64-40fc-bb31-f53ca9d02de9"
}

data "scaleway_bootscript" "mainline41511" {
  architecture = "x86_64"
  name_filter  = "x86_64 mainline 4.15.11 rev1"
}

resource "scaleway_security_group" "sg" {
  name                    = "${var.role}"
  description             = "allows smtp out"
  enable_default_security = false
}

resource "scaleway_ip" "ip" {
  server  = "${scaleway_server.server.id}"
  reverse = "mail.infosecproject.org"
}

resource "scaleway_server" "server" {
  name           = "${var.role}"
  image          = "${var.old_image}"
  type           = "VC1S"
  bootscript     = "${data.scaleway_bootscript.mainline41511.id}"
  public_ip      = "${scaleway_ip.ip.ip}"
  enable_ipv6    = true
  security_group = "${scaleway_security_group.sg.id}"
}
