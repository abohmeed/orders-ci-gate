# App logs bucket and the app's write policy.

resource "aws_s3_bucket" "logs" {
  bucket = "orders-app-logs-${var.env}"
}

resource "aws_iam_role_policy" "logs" {
  name = "app-logs"
  role = aws_iam_role.app.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "s3:*"
      Resource = ["arn:aws:s3:::orders-app-logs-${var.env}", "arn:aws:s3:::orders-app-logs-${var.env}/*"]
    }]
  })
}
