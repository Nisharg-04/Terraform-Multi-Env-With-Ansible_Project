variable "env" {
  description = "This is the environment name eg. dev/stg/prd"
  type        = string
}

variable "instance_type" {
  description = "This is the Instance Type for AWS EC2 eg. t2.micro/t2.medium/t2.small"
  type        = string
}

variable "instance_count" {
  description = "This is the count of the no. of instances I need"
  type        = number
}

variable "ami" {
  description = "This is the AMI ID for EC2 instance"
  type        = string
}

variable "volume_size" {
  description = "This is the size of Root EBS for AWS EC2"
  type        = number
}