provider "aws" {
  region  = "us-west-1"
  shared_credentials_file = "./creds"
}

# data resource to setup for resource below

data "aws_ami" "example" {
  most_recent      = true
  owners = ["099720109477"] # owner id of amz

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "new" {
  ami = data.aws_ami.example.id
  instance_type = "t2.micro"
}
