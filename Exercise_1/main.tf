# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  profile = "default"
  shared_credentials_file = "/Users/venkatagarimella/.aws/credentials"
  region = "us-east-1"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2

resource "aws_instance" "udacityT5P1R1" {
ami = "ami-0947d2ba12ee1ff75"
instance_type= "t2.micro"
tags = {
 Name= "udacity T2"
}
count= 4
subnet_id = "subnet-0f4620252d2bb6a2a"

}


# TODO: provision 2 m4.large EC2 instances named Udacity M4

resource "aws_instance" "udacityT5P1R2" {
ami = "ami-0947d2ba12ee1ff75"
instance_type = "m4.large"
tags = {
 Name= "udacity M4"
}
count = 2
subnet_id = "subnet-0f4620252d2bb6a2a"

}
