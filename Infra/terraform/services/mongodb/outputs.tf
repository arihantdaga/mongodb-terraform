output "mongodb_public_ips" {
    value = module.mongodb_replicaset.private_ips
}