resource "aws_instance" "my_ec2" {
  ami             = "ami-0b55fc9b052b03618"
  instance_type   = "t2.micro"
  
  # refering key which we created earlier
  key_name        = "frankieone-home"
  
  # refering security group created earlier
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  associate_public_ip_address = true
  subnet_id = "subnet-006f0c419c1a846e4"

}