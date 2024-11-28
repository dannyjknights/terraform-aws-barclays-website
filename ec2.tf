resource "aws_instance" "web_instance" {
  ami              = "ami-07c1b39b7b3d2525d"
  instance_type    = "t3.micro"
  key_name         = "boundary"
  user_data_base64 = data.cloudinit_config.install.rendered
  tags = {
    "Name" = "${var.barclays_name}-website"
  }
  network_interface {
    network_interface_id = aws_network_interface.barclays_target_ni.id
    device_index         = 0
  }
  lifecycle {
    ignore_changes = [
      user_data_base64,
    ]
  }
}

resource "aws_network_interface" "barclays_target_ni" {
  subnet_id               = aws_subnet.barclays_demo_subnet.id
  security_groups         = [aws_security_group.allow_all.id]
  private_ip_list_enabled = false
}

data "cloudinit_config" "install" {
  gzip          = false
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install -y apache2
    echo "<html><head><style>body { font-family: Arial, sans-serif; color: #00aeef; text-align: center; margin-top: 20%; }</style></head><body><img src="https://lobbymap.org/site//data/001/361/1361555.png" alt="Barclays Logo" width="200"><h1>Congratulations "${var.barclays_name}", you have created this website running in AWS using HashiCorp Terrraform's no-code modules! </h1></body></html>" | sudo tee /var/www/html/index.html
    sudo systemctl restart apache2
    EOF
  }
}