terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
}

provider "scaleway" {
  zone   = "fr-par-1"
  region = "fr-par"
}

variable "role" {
  default = "mail"
}

resource "scaleway_instance_security_group" "sg" {
  name                    = var.role
  description             = "allows smtp out"
  stateful                = false
  enable_default_security = false
}

resource "scaleway_instance_ip" "mail" {}

resource "scaleway_instance_ip_reverse_dns" "mail" {
  ip_id   = scaleway_instance_ip.mail.id
  reverse = "mail.infosecproject.org"
}

resource "scaleway_instance_server" "mail" {
  image             = "ubuntu_jammy"
  ip_id             = scaleway_instance_ip.mail.id
  name              = "mail"
  security_group_id = scaleway_instance_security_group.sg.id
  type              = "DEV1-S"
}
