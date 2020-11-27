#VPC Endpoints and Privatelink 
This module creates a network topology using AWS Privatelink to expose NLBs across VPCs
As described in Chapter 6 - Network Security, one way of securely facilitating communication between two services in two different VPCs is to use VPC endpoints to expose a service behing an NLB. 

In this example, I will create 3 VPCs for 3 different domains in your company.
This setup is created using the module [vpc_structure](../../lib/vpc_structure) 
* Customer VPC for customers
* Marketing VPC for marketing domain
* Finance VPC for the finance domain
   
The use case here is, Finance domain has some service called finance service that lives behind a Network Load Balancer on the Finance VPC. Let us assume, some service (s) in the Customer VPC want to consume this service. 

[Production.tf](production.tf) describes a setup in which you can create a VPC endpoint for this finance service inside the customer VPC so that calling this service can have the illusion of calling a local service. 