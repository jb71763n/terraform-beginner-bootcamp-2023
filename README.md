# Terraform Beginner Bootcamp 2023

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

#### Shebang

A Shebang (pronounced Sha-bang) tells the bash script what program will interpret the script. eg. `#!/bin/bash`
[how a Shebang works in Linux](https://en.wikipedia.org/wiki/Shebang_(Unix))

ChatGPT recommended this format for bash: `#!/usr/bin/env bash`

- for portability for different OS distributions
- will search the user's path for the batch executable

When executing the bash script we can use the `./` shorthand notation to execute the batch script.
eg. `./bin/install_terraform_cli`

If we are using a script in .gitpod.tml we need to point the script to a program to interpret it.

eg. `source ./bin/install_terraform_cli`

#### Considerations for permissions in Linux


https://en.wikipedia.org/wiki/Chmod


### Github Lifecycle (Before, Init, Command)

We need to be careful when using the init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

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

#### persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secret Storage

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces

You can also set env vars in the `.gitpod.yml` but this can only contain non-sensitive env vars.

### AWS CLI Installation

AWS CLI is installed for thwe project via the bash script [`./bin/install_AWS_cli`](./bin/install_AWS_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI EnvVars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

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
[Getting Started with IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started.html)
[Managing Access Keys in the IAM Console](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_CreateAccessKey)
