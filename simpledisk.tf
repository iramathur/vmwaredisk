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

data "vsphere_datastore" "datastore" {
  name          = "vmstore"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_disk" "lnDisk" {
  size         = 20
  vmdk_path    = "latenight_diskir.vmdk"
  datacenter   = "devcloud"
  datastore    = "vmstore"
  type         = "thin"
}