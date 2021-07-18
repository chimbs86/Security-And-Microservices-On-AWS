resource "aws_kms_key" "symmetric" {
  description             = "KMS key 1"
  deletion_window_in_days = 7
  customer_master_key_spec = "SYMMETRIC_DEFAULT" // this is the default value
  enable_key_rotation =  false

}


resource "aws_kms_key" "asymmetric" {
  tags = {
    Name = "Sample-Asymmetric-Key"
  }
  description             = "KMS key 1"
  deletion_window_in_days = 7
  customer_master_key_spec = "RSA_4096"
  enable_key_rotation =  false

}

resource "aws_kms_alias" "asymmetric_key_alias" {
  name          = "alias/asymmetric-key-alias"
  target_key_id = aws_kms_key.asymmetric.id
}