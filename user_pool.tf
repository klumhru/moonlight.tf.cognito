resource "aws_cognito_user_pool" "moonlight" {
  name = "${var.project}-${var.tier}"
}

resource "aws_cognito_user_pool_client" "players" {
  name                = "${var.project}-players-${var.tier}"
  user_pool_id        = "${aws_cognito_user_pool.moonlight.id}"
  explicit_auth_flows = ["USER_PASSWORD_AUTH"]
}

resource "aws_cognito_user_group" "players" {
  name         = "players"
  user_pool_id = "${aws_cognito_user_pool.moonlight.id}"
  description  = "Registered players"
  precedence   = 50
  role_arn     = "${aws_iam_role.players.arn}"
}

resource "aws_cognito_user_group" "administrators" {
  name         = "administrators"
  user_pool_id = "${aws_cognito_user_pool.moonlight.id}"
  description  = "Registered administrators"
  precedence   = 50
  role_arn     = "${aws_iam_role.administrators.arn}"
}
