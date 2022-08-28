#######################################
## emqx modules
#######################################

module "mongodb_replicaset" {
  source = "../../modules/mongodb"

  namespace                   = var.mongodb_namespace
  instance_count              = var.mongodb_instance_count
  instance_type               = var.mongodb_instance_type
  mongodb_region              = var.mongodb_region
  mongodb_port                = var.mongodb_port
  ssh_key_path                = var.ssh_key_path
  replica_set_name            = var.replica_set_name
  mongodb_dns_hostnames       = var.mongodb_dns_hostnames
}

