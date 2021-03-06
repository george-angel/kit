provider "scaleway" {
  version = "v1.13.0 "
  zone    = "fr-par-1"
  region  = "fr-par"
}

variable "role" {
  default = "mail"
}

resource "scaleway_instance_security_group" "sg" {
  name        = var.role
  description = "allows smtp out"
}

resource "scaleway_instance_ip" "ip" {}

resource "scaleway_instance_ip_reverse_dns" "mail" {
  ip_id   = scaleway_instance_ip.ip.id
  reverse = "mail.infosecproject.org"
}

resource "scaleway_instance_server" "server" {
  name              = var.role
  type              = "VC1S"
  enable_ipv6       = true
  ip_id             = scaleway_instance_ip.ip.id
  security_group_id = scaleway_instance_security_group.sg.id

  lifecycle {
    ignore_changes = [
      image,
      user_data,
    ]
  }

  root_volume {
    size_in_gb = 50
  }
}
