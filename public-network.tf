#AWS resource to create a VPC CIDR Block and to enable a DNS hostname to the instances
resource "aws_vpc" "barclays_demo_vpc" {
  cidr_block           = var.aws_vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "Barclays Demo Public VPC CIDR Block"
  }
}

# Create a Public subnet and assign to the VPC. The NAT gateway will be associated to this subnet
resource "aws_subnet" "barclays_demo_subnet" {
  vpc_id                  = aws_vpc.barclays_demo_vpc.id
  cidr_block              = var.aws_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone
  tags = {
    Name = "Barclays Demo Public Subnet"
  }
}

# AWS resource to create the Internet Gateway
resource "aws_internet_gateway" "barclays_demo_ig" {
  vpc_id = aws_vpc.barclays_demo_vpc.id
  tags = {
    Name = "barclays-demo-igw"
  }
}

//AWS resource to create a route table with a default route pointing to the IGW

resource "aws_route_table" "barclays_demo_rt" {
  vpc_id = aws_vpc.barclays_demo_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.barclays_demo_ig.id
  }
  tags = {
    Name = "barclays-demo-rt"
  }
}

# AWS resource to associate the route table to the CIDR blocks created
resource "aws_route_table_association" "barclays_demo_rt_associate" {
  subnet_id      = aws_subnet.barclays_demo_subnet.id
  route_table_id = aws_route_table.barclays_demo_rt.id
}
