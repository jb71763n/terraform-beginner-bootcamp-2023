# terraform beginner bootcamp 2023 - week 1

## Fixing Tags

[How to Delete Local and Remote Tags on Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

Locall delete a tag
```sh
git tag -d <tag_name>
```

Remotely delete tag

```sh
git push --delete origin tagname
```

Checkout the commit that you want to retag. Grab the sha from your Github history.

```sh
git checkout <SHA>
git tag M.M.P
git push --tags
git checkout main
```

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

### Floor function

[Floor function](https://developer.hashicorp.com/terraform/language/functions/floor)

The floor function returns the closest whole number that is less than or equal to the given value, which may be a fraction.

example:
```
> floor(5)
5
> floor(4.9)
4

```


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

## Fix using Terraform refresh
[Terraform Refresh](https://developer.hashicorp.com/terraform/cli/commands/refresh)

```sh
terraform apply -refresh-only -auto-approve

```
## Terraform Modules

### Terraform Module Structure

It is recommended to place modules in a 'modules' directory when locally developing modules but you can name it whatever you like.

### Passing Input Variables

Here we can pass input variables to our module
The module must declare it's own variables.tf
```tf
module "terrahouse_aws" {
  source = "./Modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules Sources

Using the source we can import the module from various places eg:
- locally
- Github
- Terraform Registry 

```tf
module "terrahouse_aws" {
source = "./Modules/terrahouse_aws"
}
```

[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)


## Considerations for using ChatGPT to write code

LLMs such as ChatGPT may not be trained on the latest documentation or information about Terraform.

It may produce older examples that could be deprecated, often affecting providers.

## Working with files in Terraform

### Fileexists function

[Fileexists Function](https://developer.hashicorp.com/terraform/language/functions/fileexists)
This is a built in terraform function to check for the existance of a file

```
  validation {
    condition     = fileexists(var.index_html_filepath)
    error_message = "The provided path for index.html does not exist."
  }
```

### filemd5

[filemd5 function](https://developer.hashicorp.com/terraform/language/functions/filemd5)
```
  etag = filemd5(var.index_html_filepath)
```

### Path Variable

In Terrraform there is a special variable called 'path' that allows us to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root of the project

[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

```
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = var.index_html_filepath
  etag = filemd5(var.index_html_filepath)
}

```

## Terraform Locals

Locals allows us to define local variables for use with terraform. These are not local OS env vars.
It can be very useful when we need transform data into another format and have referenced a varaible.

```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```
[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

## Terraform Data Sources

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

This allows use to source data from cloud resources that were not necessarily created using terraform.

This is useful when we want to reference cloud resources without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

## Working with JSON

We use the jsonencode to create the json policy inline in the hcl.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

## Changing the lifecycle of resources

[Resource Lifecycle](https://developer.hashicorp.com/terraform/tutorials/state/resource-lifecycle)

[Meta-Arguments Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

https://developer.hashicorp.com/terraform/language/resources/terraform-data

## Provisioners

Provisioners allow you to execute commands on compute instances eg. a AWS CLI command.

They are not recommended for use by Hashicorp because Configuration Management tools such as Ansible are a better fit, but the functionality exists.

[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Local-exec

This will execute command on the machine running the terraform commands eg. plan apply

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```

https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec

### Remote-exec

This will execute commands on a machine which you target. You will need to provide credentials such as ssh to get into the machine.

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)

  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```
https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec

## For Each Expressions

For each allows us to enumerate over complex data types

```sh
[for s in var.list : upper(s)]
```

This is mostly useful when you are creating multiples of a cloud resource and you want to reduce the amount of repetitive terraform code.

[For Each Expressions](https://developer.hashicorp.com/terraform/language/expressions/for)