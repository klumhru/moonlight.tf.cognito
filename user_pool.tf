resource "aws_cognito_user_pool" "moonlight" {
  name = "${var.project}-${var.tier}"
}
