#VPC Transit Gateway 
In this, I will create a hub and spoke setup using a transit gateway. 

In this example, I will create 3 VPCs for 3 different domains in your company.
This setup is created using the module [vpc_structure](../../lib/vpc_structure) 
* Customer VPC for customers
* Marketing VPC for marketing domain
* Finance VPC for the finance domain
   
The usecase here is that every service from each domain needs to have the ability to communicate with every other domain. 

[main.tf](main.tf) describes a setup in which you can create a transit gateway and attach all your VPCs to securely route traffic between each other. 