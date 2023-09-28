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

