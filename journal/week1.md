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

Used to specify the file with the variables on the command line with -var-file. 

```
terraform apply -var-file="testing.tfvars"
```

This allows you to have multiple varable files for testing or for use in different environments


### terraform.tfvars

This is the default file to load in terraform variables in blunk

### auto.tfvars

Any files named with auto.tfvars or auto.tfvars.json will be automatically loaded to incorporate multiple variable files to the script.

### order of terraform variables
If the same variable is assigned multiple values, Terraform uses the last value it finds, overriding any previous values. Note that the same variable cannot be assigned multiple values within a single source.

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

   - Environment variables
   - The terraform.tfvars file, if present.
   - The terraform.tfvars.json file, if present.
   - Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
   - Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)


## Terraform Import

## Dealing wtih configuration drift

## What happens if we lose our state file?

If you lose your statefile, you most likely have to tear down all your cloud infrastructure manually.

You can use terraform import but it won't work for all cloud resources. You need to check the terraform providers documentation for which resources support import. 

### Fix Missing Resources with Terraform Import

```
terraform import 
```

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

### Fix Manual Configuration

If someone goes and deletes or modifies cloud resources manually through ClickOps, if we run Terraform plan, it will attempt to put our infrastructure back into the expected state fixing configuration drift.
