# Terraform Beginner Bootcamp 2023
*Adding notes as I progress through this bootcamp to attempt to improve my engineering documentation skills* 


#### To determine what version of a machine we are running on

- we can use `cat /etc/os-release` this can be used to see current running version
    - example output: *Ubuntu 22.04.3 LTS*
    - Important to know this so you are aware of the different forms of commands will work with that *OS*
 
#### Terraform Coding Trap Example
*Issue: Refactor Terraform CLI*
- Video from course covering this
    - [Andrew Brown covers Terraform start script code trap](https://app.exampro.co/student/material/terraform-cpb/5380)
    - Timestamp: 00:04:00
- Steps to resolving this issue:
    - Intial build script not automatically building
  ```bash
      init: |
      sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
      curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
      sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" -y
      sudo apt-get update && sudo apt-get install terraform
  ```
    - Troubleshootihg this by running each command line by line
    - `sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl`
      - Command returned expeacted output
    - `curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -`
      - Returned `Warning: apt-key is deprecated. Manage keyring files in trusted.gpg.d instead (see apt-key(8)).`
      - Issue may be with Terraform install
  - Rest of commands ran as expected more *deprecation errors*

 [Terraform Install Instructions](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Adding a new folder `bin`
  - new file to store install script `install_terraform_cli`
  - Added Executable Permission to the user class `chmod u+x ./bin/install_terraform_cli.sh` [^1](https://en.wikipedia.org/wiki/Chmod)

- Added `install_terraform_cli.sh` to the `.gitpod.yaml`
- changed `init` to `before`
   - gitpod when starting up an excisting workspace wont run script if `init`
   - [Gitpod documentation](https://www.gitpod.io/docs/configure/workspaces/tasks)
     > When you restart a workspace, Gitpod already executed the init task (see above) either as part of a Prebuild or when you started the workspace for the first time.


#### Project Root ENV Variable

- To see your enviorment variables you can run
  - `env`
  - filter with `env | grep VariableName`

#### Setting and Unsetting Env Vars

- In the terminal we can ser using `export HELLO=World`

- In the termincal we can uset using `unset HELLO`

- We can set an env var temporarily when jsut running a command

```
HELLO='world' ./bin/print_message
```
Within a bash script we can set env without writing export eg. 

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

#### Printing Vars

- We can print an env var using echo eg. `echo $HELLO`

#### Scoping of Env Vars

- When you up new bash terminals in VSCode it will not be aware of env vars that you have set in another window.

- If you want to Env Vars to persist across all future bash terminals that are open you need to set env vars in your bash profile. eg. `.bash_profile`

#### Persisiting Env Vars in Gitpod

- We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'
```

- All future workspaces launched will set the env vars for all bash terminals opened in those workspaces. 

- You can also set env vars in the `.gitpod.yml` but can only contain non-senstive env 

#### AWS CLI Installaition

- AWS CLI is intitalized for the via the bash script
  - [`./bin/install_aws_cli`](./bin/install_aws_cli)

- [Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [AWS  CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

- We can check if our AWS credentials are configured correctly by running the following command:
```sh
aws sts get-caller-identity
```

- If it is successful you should see a json payload return that looks like this:

```json
{
    "UserId": "AIDARDBCXBPAEXAMPLEZM",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::075234712345678901241185:user/terraform-beginner-bootcamp"
}
```

- We'll need to generate AWS CLI credentials from IAM User in order to use the AWS CLI

## Terraform Basics

### Terraform Registry

- Terraform soruces providers and modules from the Terraform registry which is locatedx at [registry.terraform.io](https://registry.terraform.io/)

  - **Providers** is an interface to APIs that will allow to create resources in terraform 
  - **Modules** are a way to make large amount of terraform code modular, portable and sharable.

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/)

### Terraform Console

- We can see a list of all the Terraform commands by simply typing `terraform`

#### Terraform Init

- At the start of a new terraform project we will run `terraform init` to download the binaries for the terraform providers that we'll 

#### Terraform Plan

- `terraform plan`

- This will generate out a changeset, about the state of our infrastructure and what will be changed.

- We can output this changeset ie. "plan" to be passed to an apply, but often you can igore outputting. 

#### Terraform Apply

- `terraform apply`

- This will run a plan and pass the changeset to be executed by terraform. Apply should prompt `yes` or `no`.

- If we want to automatically approve an apply we can provide the auto approve flag eg. `terraform apply --auto-approve` 

### Terraform Lock Files

- `.terraform.lock.hcl` contains the locked versioning for the providers or modulues that should be used with this project.

- The Terraform Lock File **should be comitted** to your Version Control System (VSC) eg. Github 

### Terraform Stste Files

- `.terraform.tfstate` contain information about the current state of your infrastructure.

- This file **should not be commited** to your VCS.

- This file can contain sensentive data. 

- If you lose this file, you lose knowing the state of your infrastructure. 

- `.terraform.tfstate.backup` is the previous state  file state. 

### Terraform Directory

- `.terraform` directory contains binaries of terraform providers. 
