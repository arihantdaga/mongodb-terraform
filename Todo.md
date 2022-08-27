Configuring replica name
Configuring Replica Size
Configuring Port
Username and password creation
DB Creation

From Terraform, pass to ansible as well. 

Allow for different feature enabling. 
Example - slowOpThreshold and monitoring. 
Setting up cloud monitoring/ free monitoring by default. 
Allow incoming traffic from complete VPC.


# Attribution
https://medium.com/@belougatech/create-a-mongodb-cluster-in-2-command-lines-with-gcp-terraform-ansible-6b706c2d57d


# Bugs
- [ ] In the beginning mongodb tag doesn exists. So firewall creation fails. There is no explicit way to create or delete tags. 
- [ ] Right now we are asking mongodb username and password in second role at the time of initreplica, that means a user has to sit and wait for it. Lets do this automatic or take it in first role itself. 
- [ ] Handle username and password creation in first role. SECURELY. 
- [ ] Enable Hostnames - MongoDB should be started with hostnames, the hostnames should be coming from variables. - It is important - https://www.mongodb.com/docs/v5.0/tutorial/deploy-replica-set/ - Also these hostnames should be copied to /etc/hosts of the droplets -> Done via terraform itself. 
- [ ] Security - Upgrade from keyfile security to x509 Certificate. 
