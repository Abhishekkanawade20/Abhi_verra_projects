
terraform {
  backend "s3" {
    region = "ap-south-1"
    bucket = "abhi-bucket-08052025"   
    key = "abhi-bucket-08052025/abhishek"
  }
}