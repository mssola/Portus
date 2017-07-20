# Variables

variable "libvirt_uri" {
  default     = "qemu:///system"
  description = "libvirt connection url - default to localhost"
}

variable "pool" {
  default     = "default"
  description = "pool to be used to store all the volumes"
}

variable "img_source_url" {
  type        = "string"
  default     = "http://download.opensuse.org/repositories/Virtualization:/containers:/images:/KVM:/Leap:/42.2/images/Base-openSUSE-Leap-42.2.x86_64-cloud_ext4.qcow2"
  description = "URL to the openSUSE Leap 42.2 image for KVM. Note that this also accepts remote URLs"
}

variable "node_memory" {
  default     = 2048
  description = "RAM of the node expressed in bytes"
}

variable "node_vcpu" {
  default     = 2
  description = "The amount of virtual CPUs"
}

variable "worker_role" {
  default     = "portus"
  description = "The Salt role of the worker node"
}

variable "portus_source" {
  default     = "../../../"
  description = "The source code of Portus"
}

# Basics

provider "libvirt" {
  uri = "${var.libvirt_uri}"
}

resource "libvirt_network" "backend" {
  name      = "portusnet"
  mode      = "nat"
  domain    = "portus.local"
  addresses = ["10.17.3.0/24"]
}

resource "libvirt_volume" "base_volume" {
  name   = "portus_base.img"
  pool   = "${var.pool}"
  source = "${var.img_source_url}"
}

# Worker specs

resource "libvirt_volume" "worker" {
  name           = "portus_worker.img"
  pool           = "${var.pool}"
  base_volume_id = "${libvirt_volume.base_volume.id}"
}

resource "libvirt_cloudinit" "worker" {
  name               = "portus_worker_ci.iso"
  pool               = "${var.pool}"
  ssh_authorized_key = "${file("ssh/id_portus.pub")}"
  user_data          = "${file("worker.cfg")}"
}

resource "libvirt_domain" "worker" {
  name      = "portus"
  memory    = "${var.node_memory}"
  vcpu      = "${var.node_vcpu}"
  cloudinit = "${libvirt_cloudinit.worker.id}"

  disk {
    volume_id = "${libvirt_volume.worker.id}"
  }

  connection {
    type        = "ssh"
    user        = "root"
    private_key = "${file("ssh/id_portus")}"
  }

  network_interface {
    network_id     = "${libvirt_network.backend.id}"
    wait_for_lease = 1
  }

  graphics {
    type        = "vnc"
    listen_type = "address"
  }

  provisioner "file" {
    source      = "ssh/id_portus"
    destination = "/root/.ssh/id_rsa"
  }

  provisioner "file" {
    source      = "ssh/id_portus.pub"
    destination = "/root/.ssh/id_rsa.pub"
  }

  provisioner "file" {
    source      = "provision.sh"
    destination = "/tmp/provision.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /srv/Portus",
    ]
  }

  provisioner "file" {
    source      = "${var.portus_source}"
    destination = "/srv/Portus"
  }

  provisioner "remote-exec" {
    inline = [
      "bash /tmp/provision.sh --master ${libvirt_domain.worker.network_interface.0.addresses.0} --role ${var.worker_role}",
    ]
  }
}

output "ip_worker" {
  value = "${libvirt_domain.worker.network_interface.0.addresses.0}"
}
