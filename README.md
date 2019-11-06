Creating AWS infrastructure and deploy redmine and mysql service on top of it
### Project description properties and prerequisites

This is playbook to deploy Redmine application on AWS.
the playbook will create following services in AWS
-VPC
-SECURITY GROUPS
-EC2
-RDS
-CDN

Hence things are oversimplified - credentials are stored as plain text vars without ansible vault and IaC plays together with App Configuration Management.
the playbook ideally create the VPC, allocate the EC2 and RDS instances in that vpc. Also create the CDN in the same VPC

- Prerequisites:
  - Ansible latest version
  - you can use install.sh to install needed dependencies before running ansible-playbook
  - AWS account with API access credentials.

- Notices and possible issues:
  - VPC,security groups, RDS, CDN need to disable and delete it manually in AWS console.
  - RDS creation will take time, timeout is defined to 15 minutes just in case.
  - Addition of a local Host Key of the new created EC2 is used to avoid manual steps during playbook probably it could be not working if you have not permissions to change ~/.ssh/known_hosts on a local machine.

### Project structure

* [group_vars](./group_vars) -- Playbook variables folder
* [all.yml](./group_vars/all.yml) -- Playbook variables example
* [roles](./roles) -- Roles
* [common](./roles/common) -- Basic packages installation
* [aws-infra](./roles/aws-infra) -- AWS infrastructure create
* [ruby](./roles/ruby) -- Ruby packages installation
* [redmine](./roles/ruby) -- Redmine service deploy
* [jdauphant.nginx](./roles/jdauphant.nginx) -- Galaxy role for Nginx installation
* [site.yml](./site.yml) -- Main playbook to deploy all services

- Put your own AWS ssh key file (like 'EC2.pem') in the main folder, beside the playbook. File permissions should be '0600' otherwise playbook will fail.


aws_region: <set your region here, default is us-east-1
secret_key: <set your AWS secret_key here
access_key: <set your AWS access_key here

aws_keypair: <set your working AWS ssh keypair here for EC2 access, for example 'EC2'
ansible_ssh_private_key_file: <set your working AWS ssh key file name here for EC2 access, for example 'EC2.pem'

- Run playbook to create all services and wait until it will be completed:

- Check the Cloudfront distribution status in AWS console, its creation will take time. When status becomes Deployed and Enabled then you can open the service by domain name, like dxxxxxxxxxxxxx.cloudfront.net.

- Default admin credentials to Redmine are: 'admin/admin'. Service will force to set new password after first login and then you can start to use the service.

- Run playbook to cleanup all created AWS services when needed and wait until it will be completed:

- Go to AWS console - disable and then destroy the distribution, EC2, VPC, RDS after ur testing.
