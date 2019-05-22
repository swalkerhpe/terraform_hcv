#####
# Terraform Script - Demo at Team Meeting June 19
# Author - Steve Walker
# Version - 

#####
#Outputs
#####

output "public_ip" {
  description = "The Public IP"
  value       = "${aws_instance.mssql.public_ip}"
}

output "public_dns" {
  description = "The Public IP"
  value       = "${aws_instance.mssql.public_dns}"
}

output "ec2_password" { 
  value = "${rsadecrypt(aws_instance.mssql.password_data, file("${var.private_key_path}"))}"
}


