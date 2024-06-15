# cofig provider
provider "aws" {
  region  = "ap-southeast-1"
  profile = "duongdinhxuan_duong-admin"
}

# config variable
variable path_to_public_key {
  type        = string
  default     = "client.pem.pub"
  description = "Path public key client.pem.pub"
}

variable path_to_private_key {
  type        = string
  default     = "client.pem"
  description = "Path public key client.pem"
}

locals {
  bucket_result = {
    traefik = {
      hostname = "traefik"
      instance_ami = "ami-0417ea7f58950ec35"
      instance_user_name = "ubuntu"
      instance_type = "t2.small"
    }

    # bastion = {
    #   hostname = "bastion"
    #   instance_ami = "ami-04c913012f8977029"
    #   instance_user_name = "ec2-user"
    #   instance_type = "t2.micro"
    # }
  }
}

# Resources
resource "aws_key_pair" "client" {
  key_name   = "client"
  public_key = file(var.path_to_public_key)
}

resource "aws_instance" "ec2_instance" {
  for_each      = local.bucket_result
  ami           = each.value.instance_ami
  instance_type = each.value.instance_type
  key_name      = aws_key_pair.client.key_name

  provisioner "remote-exec" {
    inline = ["sudo hostnamectl set-hostname ${each.value.hostname}"]
  }

  connection {
    type        = "ssh"
    timeout     = "2m"
    host        = self.public_ip
    user        = each.value.instance_user_name
    private_key = file(var.path_to_private_key)
  }

  tags = {
    Name = each.value.hostname,
    User = each.value.instance_user_name
  }
}

output "instance_ouput" {
  value = aws_instance.ec2_instance
}

# for ansible
data "template_file" "ansible_inventory" {
  template = file("${path.module}/inventory.tpl")

  vars = {
    instances = jsonencode({
      for key, value in aws_instance.ec2_instance : key => {
        hostname = value.tags.Name
        ip       = value.public_ip
        username = local.bucket_result[key].instance_user_name
      }
    })
  }
}

resource "local_file" "ansible_inventory" {
  content  = data.template_file.ansible_inventory.rendered
  filename = "${path.module}/inventory"
}

#================================================
# Waiting for instance available fist
#================================================
data "aws_instance" "ec2_instance" {
  for_each = aws_instance.ec2_instance
  instance_id = each.value.id
}

resource "null_resource" "run_ansible" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ${path.module}/inventory ${path.module}/docker-playbook.yml"
  }

  triggers = {
    always_run = "${timestamp()}"
  }

  depends_on = [
    aws_instance.ec2_instance,
    data.aws_instance.ec2_instance,
    local_file.ansible_inventory
  ]
}

# # Inventory host resource.
# resource "ansible_host" "web1" {
#   name   = "web1"
#   groups = ["aws"] # Groups this host is part of.

#   variables = {
#     # Connection vars.
#     ansible_user = var.instance_user_name # Default user depends on the OS.
#     ansible_host = aws_instance.ec2_instance.public_ip

#     # Custom vars that we might use in roles/tasks.
#     hostname = "web1"
#   }
# }

# resource "ansible_group" "web" {
#   name     = "web"
#   children = ["aws"]

#   # Group variables that will apply to the children hosts.
#   variables = {
#     ansible_ssh_private_key_file = "~/.ssh/id_rsa"
#   }
# }

# resource "ansible_playbook" "playbook" {
#   playbook   = "docker-playbook.yml"
#   name       = "docker"
#   replayable = true

#   extra_vars = {
#     # variables:
#     os_version               = "ubuntu"
#     architecture             = "amd64"
#     docker_version_code_name = "bionic"
#   }
# }