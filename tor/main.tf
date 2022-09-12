terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}

provider "scaleway" {
  zone   = "fr-par-1"
  region = "fr-par"
}

module "relay" {
  source = "../_lib/tf/modules/tf_scw_tor"

  role           = "relay"
  instance_count = 1
}

module "bridge" {
  source = "../_lib/tf/modules/tf_scw_tor"

  role           = "bridge"
  instance_count = 2
}
