provider "aws" {
  profile = "bobilsingh"
  region  = "ap-south-1"
  access_key = "Give your access key"
  secret_key = "Give your secret key"
}

resource "aws_instance" "OS1" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = "mykey2"
  vpc_security_group_ids = [aws_security_group.firewall.id]
  
  //----> login into instance OS and runing following for application.
  connection {
    type        = "ssh"
    user        = "ec2-user"
    port        =  22
    private_key = file("C:/Users/bobil/Downloads/mykey2.pem")
    host        = aws_instance.OS1.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo yum install git -y"
    ]
  }

  tags = {
    Name = "myos"
  }
}