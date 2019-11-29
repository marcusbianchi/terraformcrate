variable "AWS_ACCESS_KEY_ID" {
  description = "Used AWS ACCESS KEY"
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "Used AWS SECRET ACCESS KEY."
}

variable "aws_region" {
  description = "Used AWS Region."
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "Used CIDR Block Address to VPC."
  default     = "200.0.0.0/16"
}

variable "subnet1_cidr_block" {
  description = "Used CIDR Block Address to the Subnet."
  default     = "200.0.0.0/28"
}

variable "sunet1_availability_zone" {
  description = "Used availability to the Subnet."
  default     = "us-east-1a"
}


variable "subnet2_cidr_block" {
  description = "Used CIDR Block Address to the Subnet."
  default     = "200.0.10.0/28"
}

variable "sunet2_availability_zone" {
  description = "Used availability to the Subnet."
  default     = "us-east-1b"
}


variable "cluster_name" {
  description = "Name of the Cluster"
  default     = "crate"
}

variable "ec2_master_AMI" {
  description = "AMI used for Master Instances"
  default     = "ami-00068cd7555f543d5"
}

variable "ec2_master_instance_type" {
  description = "Instance type for Master Instances"
  default     = "t2.small"
}

variable "ec2_master_key_name" {
  description = "Key Pair name for Master Instances"
  default     = "cratedb-key"
}

variable "ec2_master1_private_ip" {
  description = "Ip of the master node 1"
  default     = "200.0.0.10"
}

variable "ec2_master2_private_ip" {
  description = "Ip of the master node 2"
  default     = "200.0.10.10"
}

variable "ec2_slave_AMI" {
  description = "AMI used for Slaves Instances"
  default     = "ami-00068cd7555f543d5"
}

variable "ec2_slave_instance_type" {
  description = "Instance type for Slaves Instances"
  default     = "t2.small"
}

variable "ec2_slave_key_name" {
  description = "Key Pair name for Slaves Instances"
  default     = "cratedb-key"
}

variable "ec2_slave_count" {
  description = "Quantity of Slaves Instances"
  default     = "1"
}