# Mongoterra
Spin up a mongodb cluster quickly.
This projects uses Terraform and Ansible to spin up a mongodb cluster. Terraform is used to create Digitalocean resources (droplets,firewall etc) Ansible is used to provision these nodes in the cluster.

## Requirements
* Terraform
* Ansible

## How To Use
**Create Infrastructure**

```bash
cd Infra/terraform/services/mongodb 
terraform init
terraform plan
terraform apply -var "do_token=<your_do_token>" -var "ssh_key_path=<path_to_ssh_key>.pub"

```

`do_token` - Digitalocean token

`ssh_key_path` - Path to public ssh key file. This can will be used to access the droplets later. By default we are not opening database port to the world. You can only access database via ssh.


Other variables can be passed to terraform as well.
- `mongodb_region` - Digitalocean region to create the cluster in. Default - `blr1`
- `mongodb_dns_hostnames` - The hostnames of the mongodb nodes - '["mongo1.yourdomain.com","mongo2.yourdomain.com"]'. Default - ["mongo1.example.local", "mongo2.example.local", "mongo3.example.local"]
- `mongodb_instance_count` - Number of mongodb instances to create. Default - 3 (when changing this - also update mongodb_dns_hostnames)
- `mongodb_instance_type` - Important - This is the type of instance to create. Default - `s-1vcpu-1gb` List of all available types - https://docs.digitalocean.com/products/droplets/concepts/choosing-a-plan/
- `replica_set_name` - Name of the replica set. Default - `rs0`
- `mongodb_port` - Port on which mongodb is running. Default - 27120


**Provision Replica Set**


This would configure replica sets and also create super admin user with `role: userAdminAnyDatabase`. It'll ask username and password in the prompt. On successful execution, it'll automatically remove this username and password from the disk. you cannot retrieve password from the disk again. So save it somewhere safe.

```bash
cd Infra/ansible/mongodb
ansible-playbook main.yaml
```

## TODO
- [ ] Allow using existing ssh key from digitalocean
- [ ] Allow feature configuration - example - slowOpThreshold and monitoring.
- [ ] Setup free cloud monitoring
- [ ] Optionally Allow incoming traffic from entire VPC.
- [ ] Option to provide VPC id.
