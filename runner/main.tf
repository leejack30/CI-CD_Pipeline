
resource "aws_vpc" "vpc5" {
  cidr_block = "192.168.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "vpc5"
  }
}

resource "aws_internet_gateway" "gw5" {
  vpc_id = aws_vpc.vpc5.id

  tags = {
    Name = "gw5"
  }
}

resource "aws_main_route_table_association" "public5" {
  vpc_id         =aws_vpc.vpc5.id
  route_table_id = aws_default_route_table.route_table_public5.id
}

resource "aws_default_route_table" "route_table_public5" {
  default_route_table_id = aws_vpc.vpc5.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw5.id
  }

  tags = {
    Name = "route_table_public5"
  }
}

resource "aws_eip" "eip5" {
  instance = aws_instance.runner.id
  domain   = "vpc"
}
resource "aws_eip_association" "eip_assoc5" {
  instance_id   = aws_instance.runner.id
  allocation_id = aws_eip.eip5.id
}

resource "aws_subnet" "subnet5" {
  vpc_id            = aws_vpc.vpc5.id
  cidr_block        = "192.168.0.0/16"
  availability_zone = "ap-northeast-1a"
}

resource "aws_security_group" "sg5" {
  
  vpc_id      = aws_vpc.vpc5.id

  ingress {
    description = "allow_HPPT"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_iam_instance_profile" "basicweb-EC2-SSM" {
  name = "basicweb-EC2-SSM"
}

resource "aws_instance" "runner" {
  
  ami                       = "ami-013a28d7c2ea10269"
  iam_instance_profile      = "basicweb-EC2-SSM"
  instance_type             = "t2.micro"
  key_name                  = aws_key_pair.tls_key.key_name
  security_groups = [aws_security_group.sg5.id]
  subnet_id = aws_subnet.subnet5.id 
  availability_zone = "ap-northeast-1a"
  user_data = <<-EOF
   #!/bin/bash
   sudo yum update -y
   sudo yum install -y ruby wget
   cd /home/ec2-user
   sudo wget https://aws-codedeploy-ap-northeast-1.s3.ap-northeast-1.amazonaws.com/latest/install
   sudo chmod +x ./install
   sudo ./install auto
   sudo yum install -y yum-utils shadow-utils
   sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
   sudo yum -y install terraform
  EOF
 
  tags = {
    Name        = "runner"
    Environment = "runner"
  }
}
