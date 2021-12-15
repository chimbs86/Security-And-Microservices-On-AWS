
# I am working with O'Reilly on creating an interactive setup. That may be a better substitute to this repository. I will come back to this repository but thought of trying out this new way of creating an interactive AWS environment
## This is still work in progress. I have more that I havent committed yet. Please email me if you want to see some of the work in progress.
## Code for Security and Microservices on AWS

This is the codebase required for following along with the book - Security and Microservices on AWS. I will try my best to add as much supplemental code as possible to make it easy to setup a terraform repository to create a reference implementation that I discuss in the book.

I think of this codebase as something similar to what they do on cooking shows. I will try to prepare and keep all of the ingredients ready for you, so that you can play with your cloud security recipe.  

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

A basic understanding of terraform is required. But a very basic one. You can always read Appendix A to gain the bare minimum knowledge. But if not, terraform documentation is quite extensive and reading that will help as well. 

# Folder Structure

* [Appendix A](appendixa) - Terraform Cloud in 5 minutes
* [Chapter 2](chapter2) - Authentication and Authorization
* [Chapter 3](chapter3) - Foundation of encryption
* [Chapter 5](chapter5) - Network Security
* [Chapter 6](chapter6) - Public facing application security
* [Chapter 7](chapter7) - Security in Transit
* [lib](lib)-The Folder containing common modules that are used by other modules. This will contain boilerplate code that you use to create various reusable parts of our application. 
* [teardown](teardown)-The Folder that you can point your terraform to once you are done running the experiment. This folder has no resources and can act as a way of cleaning up all of your test resources. 


