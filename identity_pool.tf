resource "aws_cognito_identity_pool" "moonlight" {
  identity_pool_name = "${var.project}-${var.tier}"
}
