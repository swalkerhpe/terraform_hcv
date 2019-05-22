#####
# Terraform Script - Demo at Team Meeting June 19
# Author - Steve Walker
# Version - 

#####
#Variables
#####

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "subnet_count" {
  default = 2
}
variable "aws_ami" {}
variable "aws_instance_size" {}
variable "cidr" {}
variable "keypair" {}
variable "cidr_blocks" {}
variable "ec2_name" {}
variable "private_key_path" {}
variable "tag_name" {}
variable "subnet_cidr" {}
