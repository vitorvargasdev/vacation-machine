terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.16.0"
    }
  }
}

provider "linode" {
  token = var.linode_token
}


resource "linode_instance" "work_instance" {
  label            = "work_instance"
  image            = var.linode_image
  region           = var.linode_region
  type             = var.linode_type
  authorized_users = var.linode_authorized_users
  root_pass        = var.linode_root_pass
  private_ip       = var.linode_private_ip

  connection {
    type = "ssh"
    user = "root"
    host = self.ip_address
  }

  provisioner "local-exec" {
    command = "chmod +x zip-files.sh && ./zip-files.sh"
  }

  provisioner "file" {
    source      = "dev.zip"
    destination = "/tmp/dev.zip"
  }

  provisioner "local-exec" {
    command = "rm -rf dev.zip"
  }

  provisioner "file" {
    source      = "init.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh ${var.linode_user} ${var.linode_pass}",
    ]
  }
}
