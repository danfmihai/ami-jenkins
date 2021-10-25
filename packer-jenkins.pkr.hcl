packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "jenkins" {
  ami_name      = "${var.ami_prefix}-${local.timestamp}"
  instance_type = var.instance_type
  region        = var.region
  profile       = var.profile_name
  
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm*-x86_64-gp2"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    
    most_recent = true
    owners      = ["amazon"]
  }
  ssh_username = "ec2-user"
}

build {
  name = "packer-ami-jenkins"
  sources = [
    "source.amazon-ebs.jenkins"
  ]

  provisioner "shell" {
    script = "install.sh"
  }

}