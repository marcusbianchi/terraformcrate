# CrateDB Installation

Terraform projetct to install a CrateDB on Amazon EC2 Instaces

### Prerequisites

Required software:
- AWS CLI
- Terraform

AWS credentials configured properly (https://www.terraform.io/docs/providers/aws/index.html)

Set AWS account ID as environment variable:
```sh
export AWS_ACCOUNT_ID="111111111"
```

To create remote storage use the following command:
```sh
chmod u+x ./startup
./startup
```
> To Change the AWS Region edit the file listed on ./dynamodb/terraform.tfvars

Put your account keys on environment variables:
```sh
export TF_VAR_AWS_ACCESS_KEY_ID="anaccesskey"
export TF_VAR_AWS_SECRET_ACCESS_KEY="asecretkey"
```

## Starting the Infraestructure

Got ec2 folder and execute init command
```sh
cd ec2
terraform init
```

To Plan and review the changes made in the Cluster:

```sh
terraform plan -out "planfile"  
```

**__Review the Plan of Execution BEFORE executing it__**

To execute the changes:
```sh
terraform apply -input=false "planfile" 
```

> To Change the settings edit the file listed on ./ec2/terraform.tfvars

## Updating the Infraestructure

To Change the settings edit the file listed on ./ec2/terraform.tfvars

To Plan and review the changes made in the Cluster:

```sh
terraform plan -out "planfile"  
```

**__Review the Plan of Execution BEFORE executing it__**

To execute the changes:
```sh
terraform apply -input=false "planfile" 
```


