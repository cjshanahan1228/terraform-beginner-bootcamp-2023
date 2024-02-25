


# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "bucket_name" {
  length = 22
  upper = false
  lower = true
  special = false
}

resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result

  tags = {
    UserUuid = var.user_uuid
  }
}


