provider "scaleway" {
  region = "par1"
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
