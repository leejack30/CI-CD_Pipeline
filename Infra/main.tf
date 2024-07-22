
resource "aws_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "main_gw"
  }
}

resource "aws_main_route_table_association" "public" {
  vpc_id         =aws_vpc.vpc.id
  route_table_id = aws_default_route_table.route_table_public.id

}

resource "aws_default_route_table" "route_table_public" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "route_table_public"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_default_route_table.route_table_public.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_default_route_table.route_table_public.id
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "192.168.2.0/24"
  availability_zone = "ap-northeast-1c"
  tags = {
    Name = "subnet2"
  }
}

 resource "aws_network_interface" "proxy_ip1" {
  subnet_id       = aws_subnet.subnet1.id
  private_ips     = ["192.168.1.5"]
  security_groups = [aws_security_group.proxy_sg.id]
}

 resource "aws_network_interface" "proxy_ip2" {
  subnet_id       = aws_subnet.subnet2.id
  private_ips     = ["192.168.2.5"]
  security_groups = [aws_security_group.proxy_sg.id]
}
