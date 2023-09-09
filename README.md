# terraform-ansible-ec2-nginx

This simple project automate the installation of Nginx in a AWS EC2 instance using Terraform and Ansible

## Configure AWS
### first of all you need to install:
  - AWS CLI
  - Terraform
  - Ansible
  
then you need to run the next command:

```aws configure```

then you will have to define your AWS_ACCESS_KEY, AWS_SECRET_KEY and AWS_REGION


## Terraform execution
```terraform init```

```terraform plan```

```terraform apply```

## To destroy infrastructure
```terraform destroy```

now you can check in the browser if Nginx was successfully installed 