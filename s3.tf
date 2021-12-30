resource "aws_s3_bucket" "code-pipeline-artifact" {
  acl = "private"
}