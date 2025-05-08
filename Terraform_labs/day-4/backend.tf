
terraform {
  backend "s3" {
    region = var.region
    bucket = "abhi-bucket-08052025"   
    key = "abhi-bucket-08052025/abhishek"
  }
}