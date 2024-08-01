#create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "cust-vpc"
  }

}


#create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "cust-internet-gateway"
  }
}

#create subnets
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.main.id
  availability_zone = "us-west-1a"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "cust-subnet"
  }
}

#create routetable
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

#Edit routes
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

#Edit subnet association
resource "aws_route_table_association" "rsa" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.rt.id
}

#create Security group
resource "aws_security_group" "dev" {
    vpc_id = aws_vpc.main.id
    name        = "allow_traffic"
    description = "Allow TLS inbound traffic and all outbound traffic"
    tags = {
      Name = "cust_security_group"
    }
   ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  egress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
}

#Launch Ec2 instance
resource "aws_instance" "ins" {
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = var.key
  subnet_id = aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.dev.id]
  tags = {
    Name = "Ec2-instance"
  }
  
}
