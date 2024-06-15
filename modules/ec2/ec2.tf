resource "aws_instance" "in-pub" {
  count                  = var.enable_ec2 ? var.public_instances : 0
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = aws_key_pair.ec2[0].key_name
  user_data              = file(var.file_path)
}

resource "aws_instance" "in-private" {
  count                  = var.enable_ec2 ? var.private_instances : 0
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = aws_key_pair.ec2[0].key_name
  user_data              = file(var.file_path)
}

resource "tls_private_key" "key_gen" {
  count     = var.enable_ec2 ? 1 : 0
  algorithm = var.rsa_algorithm
  rsa_bits  = var.rsa_bit
}

resource "aws_key_pair" "ec2" {
  count      = var.enable_ec2 ? 1 : 0
  key_name   = "priv-key"
  public_key = tls_private_key.key_gen[0].public_key_openssh
}

resource "local_file" "key-file" {
  count    = var.enable_ec2 ? 1 : 0
  content  = tls_private_key.key_gen[0].private_key_pem
  filename = "private-key"
}
