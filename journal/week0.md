# terraform beginner bootcamp - week 0

# Terraform Beginner Bootcamp 2023

- [Terraform Beginner Bootcamp 2023](#terraform-beginner-bootcamp-2023)
  * [Project Issues](#project-issues)
    + [Issue 11](#issue-11)
    + [Issue 13](#issue-13)
    + [Issue 15 (work around for terrafrom login issue in Issue 13)](#issue-15---work-around-for-terrafrom-login-issue-in-issue-13)
    + [Issue 19 - create table of contents in readme.md](#issue-19-create-table-of-contents-for-readmemd)
  * [semantic versioning :mage:](#semantic-versioning--mage-)
  * [Install the Terraform CLI](#install-the-terraform-cli)
    + [Considerations with the Terraform CLI changes](#considerations-with-the-terraform-cli-changes)
    + [Considerations for Linux Distribution](#considerations-for-linux-distribution)
    + [Refactoring into BASH scripts](#refactoring-into-bash-scripts)
  * [Install the AWS CLI](#install-the-aws-cli)
  * [Gitpod Considerations](#gitpod-considerations)
    + [persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
    + [Github Lifecycle : Before, Init, Command](#github-lifecycle---before--init--command)
  * [Terraform Basics](#terraform-basics)
    + [Terraform registry](#terraform-registry)
      - [Providers](#providers)
    + [Terraform Console](#terraform-console)
    + [Terraform Lock Files](#terraform-lock-files)
    + [Terraform State Files](#terraform-state-files)
    + [Terraform Directory](#terraform-directory)
  * [Terraform Cloud Basics](#terraform-cloud-basics)
    + [Terraform Cloud Backend](#terraform-cloud-backend)
  * [Linux Shell Scripting Considerations](#linux-shell-scripting-considerations)
    + [Aliases in BASH](#aliases-in-bash)
    + [Considerations for permissions in Linux](#considerations-for-permissions-in-linux)
    + [Shebang](#shebang)
    + [Working with Env Vars'](#working-with-env-vars-)
      - [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
      - [Printing Vars](#printing-vars)
      - [Scoping of vars](#scoping-of-vars)

## Project Issues

### Issue 11
Found that the random provider needed to be set to lowercase and numeric only in order to comply with S3 bucket naming requirements.
In additon, in order to create a more random name for the S3, the character count for the randomization was increased to 32 characters. 

### Issue 13
There is an issue with creating the token to connect to the terraform.cloud environment within gitpod. You need to create the token [here](https://app.terraform.io/app/settings/tokens?source=terraform-login) and either add it when you exit out of the text editor that comes up as part of the 'terraform login' process or within the '/home/gitpod/.terraform.d/credentials.tfrc.json' file prior to running 'terraform init'

Found that a variable set was needed in terraform.cloud with the environmental variables AWS_SECRET_ACCESS_KEY, AWS_ACCESS_KEY, and AWS_DEFAULT_REGION in order for the AWS provider to not give an error when performing 'terraform plan' [Variable Set in Terraform.cloud](https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-create-variable-set)

[Terraform Credentials Storage](https://developer.hashicorp.com/terraform/cli/commands/login)

### Issue 15 - work around for terrafrom login issue in Issue 13
Added batch script generate_tfrc_credentals to bin folder and called it n gitpod.yml in order to have the credentals stored in the env var TERRAFORM_CLOUD_TOKEN be added to the credentials.tfrc.json file so 'terraform login' will not need to be done in every session.

### Issue 19 create table of contents for readme\.md
Used site https://ecotrust-canada.github.io/markdown-toc/ to generate table of contents for readme.md


## semantic versioning :mage:

This project is going to utilize semantic versioning for its tagging
[semver.org](https://semver.org/)

The general format:
**MAJOR.MINOR.PATCH**, eg. '1.0.1'

Given a version number **MAJOR.MINOR.PATCH**, increment the:

   - **MAJOR** version when you make incompatible API changes
   - **MINOR** version when you add functionality in a backward compatible manner
   - **PATCH** version when you make backward compatible bug fixes


## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI installation instructions have changed due to gpg keyring changes. 
We needed to refer to the latest CLI instructions via Terraform documentation and change the scripting for install. 

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution
This project is built against Ubuntu.
Please consider checking your Linux distribution and change accordingly to distibution needs

[How to Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking the OS version
```
$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into BASH scripts

While fixing the Terraform CLI gpg deprication issues, we noticed the bash scripts steps were a considerably amount more code. 
We decided to create a BASH script to install the Terraform CLI.

- This will keep the Gitpod Task ([.gitpod.yml](.gitpod.yml)) File tidy
- This will allow us an easier to debug and execute manually Terraform CLI install
- This will allow better portability for other projects that need to install Terraform CLI

## Install the AWS CLI

AWS CLI is installed for thwe project via the bash script [`./bin/install_AWS_cli`](./bin/install_AWS_cli)

- [Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [AWS CLI EnvVars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials are configured correctly by using the following AWS CLI command:
```sh
aws sts get-caller-identity
```
If it is successful, you should see a json payload return that looks liek this:
```json
{
    "UserId": "AIDAQUJLYJ4A7HKE!!!!!",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::0435783!!!!!:user/terraforrm-beginner-bootcamp"
}
```

We'll need to generate AWS CLI credentials IAM user in order to use the AWS CLI

- [Getting Started with IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started.html)
- [Managing Access Keys in the IAM Console](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_CreateAccessKey)



## Gitpod Considerations

### persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secret Storage

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces

You can also set env vars in the `.gitpod.yml` but this can only contain non-sensitive env vars.

### Github Lifecycle : Before, Init, Command

We need to be careful when using the init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks


## Terraform Basics

### Terraform registry

Terraform sources their providers and modules from the Terraform registry which is located at [Terraform Registry](https://registry.terraform.io/)

- **Providers** is an interface to APIs that weill allow you to create resources in terraform.
- **Modules** are a way to make large amounts of terraform code modular, portable and sharable.

#### Providers

Terraform registry providers are located at: registry.terraform.io

- [Random Provider Documentation](https://registry.terraform.io/providers/hashicorp/random/latest/docs)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)


### Terraform Console

We can see a list of all the Terraform commands by simply typing 'terraform'

**Terraform commands**

- **terraform init** : initializes a working directory containing Terraform configuration files. This is the first command that should be run after writing a new Terraform configuration. Downloads the binaries for the terraform providers used in the project
- **terraform plan** : creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure. Generates a changeset about the state of the infrastucture that will be changed. This canb be output to an apply but often outputting is ignored. 
- **terraform apply** : executes the actions proposed in a Terraform plan. Should prompt for yes or no. 
    - terraform apply --auto-approve : executes the actions proposed in a Terraform plan without manual approval needed.
- **terraform destroy** : destroy all remote objects managed by a particular Terraform configuration.
    - terraform destroy --auto-approve : destroy all remote objects managed by a particular Terraform configuration without asking for approval

### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the provider or modules that should be used with this project.

The Terraform lock file **should be committed** to your version control system (VCS) eg. Github

### Terraform State Files

`.terraform.tfstate` contains information about the current state of your infrastructure. This file **should not be committed** to your VCS.

This file can contain sensitive data.

If you lose this file, you lose knowing the state of your infrastructure.

`.terraform.tfdtate.backup` is the previous state file

### Terraform Directory

`.terraform` is the directory that contains the terraform files

There should only be a single terrafrom provider block

```hcl
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}
```

## Terraform Cloud Basics

Terraform cloud backend uses a format where a **Project** may contain multiple **Workspaces**
- **Project** : Terraform Cloud projects let you organize your workspaces into groups. You can structure your projects based on your organization's resource usage and ownership patterns, such as teams, business units, or services. [More Information](https://developer.hashicorp.com/terraform/tutorials/cloud/projects)
- **Workspaces** : A workspace contains everything Terraform needs to manage a given collection of infrastructure, and separate workspaces function like completely separate working directories. [More Information](https://developer.hashicorp.com/terraform/cloud-docs/workspaces)

### Terraform Cloud Backend 

To add the terraform cloud backend, you must know the organization and workspace to store the data and it must be added to the 'terraform' code block in the main.tf file

```hcl
terraform {
    # Add the Terraform Cloud backend
    cloud {
    organization = "orgname"

    workspaces {
      name = "workspacename"
    }
  }
  required_providers {
    # Add the Terraform Random Provider
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      # Add the Terraform AWS Provider
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}
```

Connect the backend using 'terraform login' where you are required to supply a token (see Project Findings Issue 13 above). 
Once connected to the backend, subsequent terraform actions (ie. init, plan, etc.) will place their data in the workspace provided in the 'cloud' code block.

## Linux Shell Scripting Considerations

### Aliases in BASH

Bash aliases are essentially shortcuts that can save you from having to remember long commands and eliminate a great deal of typing when you are working on the command line. 

**Creating BASH Aliases**
```sh
alias alias_name="command_to_run"
```
Example: alias ll="ls -la"

Aliases to not persist after the session ends unless they are declared in the ~/.bash_profile or ~/.bashrc file.

### Considerations for permissions in Linux

Use the chmod command to adjust the permisions on linux files

https://en.wikipedia.org/wiki/Chmod

example: chmod u+x ./executablefilename

### Shebang

A Shebang (pronounced Sha-bang) tells the bash script what program will interpret the script. eg. `#!/bin/bash`
[how a Shebang works in Linux](https://en.wikipedia.org/wiki/Shebang_(Unix))

ChatGPT recommended this format for bash: `#!/usr/bin/env bash`

- for portability for different OS distributions
- will search the user's path for the batch executable

When executing the bash script we can use the `./` shorthand notation to execute the batch script.
eg. `./bin/install_terraform_cli`

If we are using a script in .gitpod.tml we need to point the script to a program to interpret it.

eg. `source ./bin/install_terraform_cli`

### Working with Env Vars'

We can list out all Environment variables using the `env` command

We can filter specific env vars using grep eg. `env | grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='World'`
In the terminal we can unset using `unset HELLO`

We can set an env var temporarily when just running a command

```
HELLO='World' ./bin/print_message
```
Within a bash script we can set env without writing export eg,
```sh
#!/usr/bin/env bash
HELLO='world'
echo $HELLO
```

#### Printing Vars

We can prtint an env var using echo eg. `echo $HELLO`

#### Scoping of vars

When you open up new bash terminal sessions in VSCode, it will not be aware of env vars thgat you have set in another window.

If you want Env Vars to persist across all future bash terminals that are open, you need to set env vars in your baash profile eg `.bash_profile`