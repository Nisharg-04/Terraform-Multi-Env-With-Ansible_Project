resource "random_string" "unique_suffix" {
  length  = 6
  upper   = false
  special = false
}
resource "aws_s3_bucket" "my_bucket" {
  bucket = "${var.env}-bucket-${random_string.unique_suffix.result}"
  
  tags = {
    Name = "${var.env}-bucket"
    Environment = var.env
  }
}