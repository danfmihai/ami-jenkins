variable "ami_prefix" {
  default = "ami-jenkins-terraform"
  type    = string
}

variable "instance_type" {
  default = "t2.micro"
}

variable "region" {
  default = "us-east-1"
}

variable "profile_name" {
  default = "jenkins"
}