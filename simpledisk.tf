variable "server" {}
variable "password" {}
variable "user_name" {}
#variable "disk_label" {}
provider "vsphere" {
  user           = "${var.user_name}"
  password       = "${var.password}"
  vsphere_server = "${var.server}"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "devcloud"
}

data "vsphere_vmdkpath" "vmdkpath" {
  name = "${var.volName}"
  datacenter_id = "${data.vsphere_vmdkpath.vmdkpath.id}"
}

data "vsphere_datastore" "datastore" {
  name          = "${var.datastore}"
  datacenter_id = "${data.vsphere_datacenter.datastore.id}"
}

resource "vsphere_virtual_disk" "lnDisk" {
  size         = 20
  vmdk_path    = "${data.vsphere_vmdkpath.datastore.id}"
  datacenter   = "devcloud"
  datastore    = "${data.vsphere_datastore.datastore.id}"
  type         = "thin"
}
