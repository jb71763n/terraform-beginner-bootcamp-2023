# terraform beginner bootcamp 2023 - week 1

## Root Module Structure

Our root module structure is as follows:
```
PROJECT_ROOT
|
├── main.tf          # everything else
├── variables.tf     # stores the structure of input variables
├── providers.tf     # define required providers and their configuration
├── outputs.tf       # stores our outputs
├── terraform.tfvars # the data of variables to load into our terraform project
└── readme.md        # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

# Terraform Input Variables
### Terrafom Cloud Variables

In terraform we can set two types of variables
- Environment variables - those you would set in your bash terminal eg. AWS Credentials
- Terraform Variables - Those you would normally set in your tfvars file

We can set Terraform Cloud Variables to be sensitive so they are not shown visibly in the UI.

### Loading Terraform Input Variables
[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the '-var' flag to sent an input variable or override a variablke in the .tfvars file eg. 'terraform -var user_id="my-user_id"'

### var -file flag

- TODO: research this flag

### terraform.tfvars

This is the default file to load in terraform variables in blunk

### auto.tfvars

- TODO: document this functionality for terraform cloud

### order of terraform variables

- TODO: document which terraform variables take precident

