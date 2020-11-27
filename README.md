# Code for Security and Microservices on AWS

This is the codebase required for following along with the book - Security and Microservices on AWS. I will try my best to add as much supplemental code as possible to make it easy to setup a terraform repository to create a reference implementation that I discuss in the book. 

The aim here is to be able to fork this repository, apply the plan and have a reference implementation ready to poke around on your AWS account without any additional setup required. I will try my best to use convention over configuration to ensure the setup is as simple as possible.   

In no way am I suggesting, terraform is the only way of building your infrastructure, but my aim here is to simplify the boilerplate setup as much as possible so you can concentrate on higher level design decisions instead of the implementation level details. 

***Given the complications associated with multi account setup, the code present in this repository will be strictly restricted to single account setups.*** 
 
 However, if you do have a multi account setup, the individual modules should work as is and you will only have to break them down by resource.  
## Getting Started
**If you are new to Terraform Cloud, please read Appendix A in the book which brings you up to speed on some of the basic concepts of terraform cloud.**  

First step will be to create an account with Terraform Cloud. While this code can be run locally as well, I will recommend using terraform cloud to run this just for the ease of use. 

You should then fork this repository on your own github account and experiment with various folders.
Each top level chapter is a folder inside the root directory. 

Within each folder, a sub folder is created for each example item.

At the end of your exercise, you can use the [Teardown](teardown) folder to remove any infrastructure that you created as a result of this code.  

## What are the prerequisites?

You must have an AWS account and provide your AWS Access Key ID and AWS Secret Access Key to Terraform Cloud. Terraform Cloud encrypts and stores variables using [Vault](https://www.vaultproject.io/). For more information on how to store variables in Terraform Cloud, see [our variable documentation](https://www.terraform.io/docs/cloud/workspaces/variables.html).

The values for `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` should be saved as environment variables on your workspace.

# Folder Structure

* [lib](lib) folder contains common modules that are used by other modules


