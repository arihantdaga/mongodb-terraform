From Terraform, pass to ansible as well. 
Allow for different feature enabling. 
Example - slowOpThreshold and monitoring. 
Setting up cloud monitoring/ free monitoring by default. 
Allow incoming traffic from complete VPC.


# Attribution
https://medium.com/@belougatech/create-a-mongodb-cluster-in-2-command-lines-with-gcp-terraform-ansible-6b706c2d57d


# Bugs
- [ ] Right now we are asking mongodb username and password in third role at the time of setupuser, that means a user has to sit and wait for it. Lets do this automatic or take it in first role itself. 
- [ ] Security - Upgrade from keyfile security to x509 Certificate. 