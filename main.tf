resource "aws_instance" "server1" {
  ami           = "ami-026b57f3c383c2eec"
  instance_type = "t2.micro"
  key_name      = "week7d2"
  tags = {
    Name = "Terraform server"
    Team = "DevOps"
    env  = "dev"
  }
  user_data = file("install.sh")
}

resource "aws_ebs_volume" "vol1" {
  availability_zone = aws_instance.server1.availability_zone
  size              = 10

  tags = {
    Name       = "terraform volume"
    Team       = "Cloud"
    created-by = "Terraform"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.vol1.id
  instance_id = aws_instance.server1.id
}
