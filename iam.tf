resource "aws_iam_role" "cicd-pipeline-IAM" {
  name = "cicd-pipeline-IAM"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

data "aws_iam_policy_document" "tf-cicd-pipeline-policies" {
  statement{
    sid = ""
    actions = ["codestar-connections:Useconnection"]
    resources = ["*"]
    effect = "Allow"
  }
  statement{
    sid = ""
    actions = ["cloudwatch:*","s3:*","codebuild:*"]
    resources = ["*"]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "tf-cicd-pipeline-policy" {
  name = "tf-cicd-pipeline-policy"
  path = "/"
  description = "pipeline policy"
  policy = data.aws_iam_policy_document.tf-cicd-pipeline-policies.json
}

resource "aws_iam_role_policy_attachment" "tf-cicd-codebuild-attachment-1" {
  policy_arn = aws_iam_policy.tf-cicd-pipeline-policy.arn
  role = aws_iam_role.cicd-pipeline-IAM.id
}

resource "aws_iam_role_policy_attachment" "tf-cicd-codebuild-attachment-2" {
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
  role = aws_iam_role.cicd-pipeline-IAM.id
}