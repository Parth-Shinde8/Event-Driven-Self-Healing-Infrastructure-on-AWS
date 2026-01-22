resource "aws_instance" "app_server" {
  ami                  = "ami-0f58b397bc5c1f2e8"
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.app_ec2_profile.name
  key_name             = "aiops-key"

  tags = {
    Name = "AIOps-App-Server"
  }
}
