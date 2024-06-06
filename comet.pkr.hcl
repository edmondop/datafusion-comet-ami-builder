packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "ami_prefix" {
  type    = string
  default = "emr-datafusion-comet"
}

variable "build_instance_type" {
  type = string
  // Need a large amount of memory to compile
  default = "t2.2xlarge"
}

variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "java_version" {
  type    = string
  default = "8.0.412-amzn"
}

variable "spark_version" {
  type    = string
  default = "3.4"
}

variable "comet_version" {
  type    = string
  default = "8c532be"
}

# This image should match the image EMR would use to run the cluster.
# For example, if you want to run Spark 3.4 you need EMR 6.15 that uses
# Amazon Linux Karoo. If you are in doubt, please launch a standard
# cluster and use  `cat /etc/os-release` and `cat /etc/system-release`
# to identify the right source ami
variable "source_ami" {
  type    = string
  default = "ami-0c9921088121ad00b"
}


variable "rust_version" {
  type    = string
  default = "1.77"
}

variable "ssh_username" {
  type    = string
  default = "ec2-user"
}

source "amazon-ebs" "builder" {
  ami_name      = "${var.ami_prefix}-${var.java_version}-${var.spark_version}"
  instance_type = "${var.build_instance_type}"
  region        = "${var.aws_region}"
  source_ami    = "${var.source_ami}"
  ssh_username  = "${var.ssh_username}"

 launch_block_device_mappings {
    device_name = "/dev/xvda"
    volume_size = 100
    volume_type = "gp2"
  }
}

build {
  name = "datafusion-comet-emr"
  sources = [
    "source.amazon-ebs.builder"
  ]

  provisioner "shell" {
    script = "setup.sh"
    environment_vars = [
      "JAVA_VERSION=${var.java_version}",
      "SPARK_VERSION=${var.spark_version}",
      "COMET_VERSION=${var.comet_version}"
    ]
  }

}
