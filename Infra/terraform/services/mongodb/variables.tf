

## common

variable "mongodb_region" {
  type        = string
  default     = "blr1"
  description = "digitalocean region"
}

variable "do_token" {
  description = "DigitalOcean Access Token"
  type        = string
  default     = ""
}


variable "mongodb_namespace" {
  description = "mongodb namespace"
  type        = string
  default     = ""
}

variable "mongodb_instance_count" {
  description = "the count of the mongodb instance"
  type        = number
  default     = 3
}

variable "mongodb_instance_type" {
    description = "the type of digitalocean instance"
    type        = string
    default     = "s-1vcpu-1gb"
}

variable "replica_set_name" {
  description = "the name of the replica set"
  type        = string
  default     = "rs0"
}

variable "mongodb_port" {
  description = "Port used by the mongodb cluster."
  type        = number
  default     = 27120
}

variable "ssh_key_path" {
    description = "path to the ssh key"
    type        = string
    default     = ""
}

# variable "mongodb_amdin_user" {
#     description = "Mongodb Super admin username"
#     type = string
# }

# variable "mongodb_amdin_pass" {
#     description = "Mongodb Super admin password"
#     type = string
# }