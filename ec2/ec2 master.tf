# Master Instance 1
resource "aws_instance" "crate-instance-master1" {
  ami               = var.ec2_master_AMI
  instance_type     = var.ec2_master_instance_type
  key_name          = var.ec2_master_key_name
  subnet_id         = aws_subnet.crate_public_sn_01.id
  user_data_base64  = base64encode(local.userdata_master)
  private_ip        = var.ec2_master1_private_ip
  tags = {
    Name    = "terraform-master-1"
    cluster = var.cluster_name
  }
  security_groups             = [aws_security_group.crate_public_sg.id]
}

resource "aws_alb_target_group_attachment" "aws_alb_target_group_attachment_master1_4200" {
  target_group_arn = aws_alb_target_group.tf_tg.arn
  target_id        = aws_instance.crate-instance-master1.id
  port             = 4200
}

# Master Instance 2
resource "aws_instance" "crate-instance-master2" {
  ami               = var.ec2_master_AMI
  instance_type     = var.ec2_master_instance_type
  key_name          = var.ec2_master_key_name
  subnet_id         = aws_subnet.crate_public_sn_02.id
  user_data_base64  = base64encode(local.userdata_master)
  private_ip        = var.ec2_master2_private_ip
  tags = {
    Name    = "terraform-master-2"
    cluster = var.cluster_name
  }
  security_groups             = [aws_security_group.crate_public_sg.id]
}

resource "aws_alb_target_group_attachment" "aws_alb_target_group_attachment_master2_4200" {
  target_group_arn = aws_alb_target_group.tf_tg.arn
  target_id        = aws_instance.crate-instance-master2.id
  port             = 4200
}


# Master Instances Init Script for CrateDB Cluster Configuration
locals {
  userdata_master = <<USERDATA
  #!/bin/bash
  set -o xtrace
  sudo sysctl -w vm.max_map_count=262144
  sudo sysctl -w fs.file-max=65536
  sudo sysctl -w vm.swappiness=1
  useradd -m -p 'c34t3' -s /bin/bash crate
  usermod -aG sudo crate
  echo "crate soft nofile 65536" >> /etc/security/limits.conf
  echo "crate hard nofile 65536" >> /etc/security/limits.conf
  echo "export CRATE_JAVA_OPTS='-Xms1g -Xmx1g'" >> /etc/environment
  sudo sysctl -p
  sudo amazon-linux-extras install java-openjdk11
  sudo mkdir /etc/crate 
  sudo curl https://cdn.crate.io/downloads/releases/crate-4.0.9.tar.gz --output /etc/crate/crate-4.0.9.tar.gz
  sudo tar -xzf /etc/crate/crate-*.tar.gz  -C /etc/crate
  sudo chown -R crate /etc/crate 
  sudo -u crate  /etc/crate/crate-4.0.9/bin/crate\
  -Ccluster.name=${var.cluster_name}\
  -Cnetwork.host=_eth0_\
  -Cauth.host_based.enabled=false\
  -Cdiscovery.seed_providers=ec2\
  -Cdiscovery.ec2.access_key=${var.AWS_ACCESS_KEY_ID}\
  -Cdiscovery.ec2.secret_key=${var.AWS_SECRET_ACCESS_KEY}\
  -Cdiscovery.ec2.any_group=false\
  -Cdiscovery.ec2.groups=crate_public_sg\
  -Cdiscovery.ec2.availability_zones=${var.sunet1_availability_zone},${var.sunet2_availability_zone}\
  -Cdiscovery.ec2.tag.cluster=${var.cluster_name}\
  -Cdiscovery.ec2.endpoint='https://ec2.${var.aws_region}.amazonaws.com'\
  -Cgateway.recover_after_nodes=3\
  -Cgateway.expected_nodes=3\
  -Ccluster.initial_master_nodes=${var.ec2_master1_private_ip},${var.ec2_master2_private_ip}
  USERDATA

}
