

resource "aws_key_pair" "local_key_pair" {
  key_name   = "local_key_pair"
  public_key = file("/home/tharindu-107455/.ssh/id_rsa.pub")
}


resource "aws_instance" "nginx_server" {
  instance_type          = var.instance_type
  ami                    = var.ami_id
  vpc_security_group_ids = [var.public_security_group]
  subnet_id              = var.public_subnet[0]
  key_name               = aws_key_pair.local_key_pair.key_name
  tags = {
    "Name" = "nginx_server"
  }
}

resource "aws_launch_template" "web_servers_launch_tmp" {
  name_prefix            = "web_servers"
  image_id               = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.private_security_group]
  key_name               = aws_key_pair.local_key_pair.key_name


  tags = {
    Name = "web_servers_launch_tmp"
  }
}

resource "aws_autoscaling_group" "web_servers_asg" {
  name                = "web_servers_asg"
  vpc_zone_identifier = tolist(var.public_subnet)
  min_size            = 3
  max_size            = 3
  desired_capacity    = 3

  launch_template {
    id      = aws_launch_template.web_servers_launch_tmp.id
    version = "$Latest"
  }

  provisioner "local-exec" {
    command = "/home/tharindu-107455/devpos_hobby_projects/aws-nginx-lb-multi-webserver/terraform/modules/compute_instances/getips.sh"
  }
}
