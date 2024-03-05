resource "aws_security_group" "ssh_access" {
  name_prefix = "ssh-access-"  # Prefixo para o nome do grupo de segurança

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["187.19.176.164/32"]  # Substitua "seu_ip_publico" pelo seu IP público
  }

  # Pode adicionar outras regras de entrada e saída conforme necessário
}
