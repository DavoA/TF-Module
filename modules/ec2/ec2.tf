resource "aws_instance" "in-pub" {
  count                  = var.enable_ec2 ? 1 : 0
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = aws_key_pair.ec2[0].key_name
  user_data = templatefile("${path.module}/user_data.sh", {
    visibility = "public"
  })
}

resource "aws_instance" "in-private" {
  count                  = var.enable_ec2 ? 1 : 0
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = aws_key_pair.ec2[0].key_name
  user_data = templatefile("${path.module}/user_data.sh", {
    visibility = "private"
  })
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
