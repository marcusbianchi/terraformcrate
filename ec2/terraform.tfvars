aws_region               = "us-east-1"
vpc_cidr_block           = "200.0.0.0/16"
subnet1_cidr_block        = "200.0.0.0/28"
sunet1_availability_zone  = "us-east-1a"
subnet2_cidr_block        = "200.0.10.0/28"
sunet2_availability_zone  = "us-east-1b"
cluster_name             = "crate"
ec2_master_AMI           = "ami-00068cd7555f543d5"
ec2_master_instance_type = "t2.small"
ec2_master_key_name      = "cratedb-key"
ec2_master1_private_ip   = "200.0.0.10"
ec2_master2_private_ip   = "200.0.10.10"
ec2_slave_AMI            = "ami-00068cd7555f543d5"
ec2_slave_instance_type  = "t2.small"
ec2_slave_key_name       = "cratedb-key"
ec2_slave_count          = "1"
