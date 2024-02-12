variable "linode_token" {
  description = "The token to use for Linode API operations"
  default = ""
}

variable "linode_region" {
  description = "The region to deploy Linode resources in"
  default = "us-east"
}

variable "linode_image" {
  description = "The image to use for the Linode"
  default = "linode/ubuntu18.04"
}

variable "linode_type" {
  description = "The type of Linode to deploy"
  default = "g6-standard-1"
}

variable "linode_root_pass" {
  description = "The root password for the Linode"
  default = ""
}

variable "linode_authorized_users" {
  description = "The list of users to add to the Linode"
  default = []
}

variable "linode_private_ip" {
  description = "The private IP address to assign to the Linode"
  default = false
}

variable "linode_user" {
  description = "User to use for SSH access"
  default = "default"
}

variable "linode_pass" {
  description = "The password for the Linode user"
  default = ""
}