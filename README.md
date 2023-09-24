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




