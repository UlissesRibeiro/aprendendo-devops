resource "aws_instance" "laboratorio-01" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name = aws_key_pair.deployer.key_name
  #vpc_security_group_ids = [aws_security_group.ssh_access.id]
  
  user_data = file("apache.sh")


  tags = {
    Name = "laboratorio-01"
  }
}