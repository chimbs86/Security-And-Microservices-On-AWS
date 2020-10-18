# Code for Security and Microservices on AWS

This is the codebase required for following along with the book - Security and Microservices on AWS
## Getting Started
First step will be to create an account with Terraform Cloud. While this code can be run locally as well, I will recommend using terraform cloud to run this just for the ease of use. 

You should then fork this repository on your own github account and experiment with various folders.
Each top level chapter is a folder inside the root directory. 

Within each folder, a sub folder is created for each example item. 

## What are the prerequisites?

You must have an AWS account and provide your AWS Access Key ID and AWS Secret Access Key to Terraform Cloud. Terraform Cloud encrypts and stores variables using [Vault](https://www.vaultproject.io/). For more information on how to store variables in Terraform Cloud, see [our variable documentation](https://www.terraform.io/docs/cloud/workspaces/variables.html).

The values for `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` should be saved as environment variables on your workspace.
