resource "aws_kms_key" "symmetric" {
  description             = "KMS key 1"
  deletion_window_in_days = 1
  customer_master_key_spec = "SYMMETRIC_DEFAULT" // this is the default value
  enable_key_rotation =  false

}


resource "aws_kms_key" "asymmetric" {
  description             = "KMS key 1"
  deletion_window_in_days = 1
  customer_master_key_spec = "ECC_SECG_P256K1" // this is the default value
  enable_key_rotation =  false

}