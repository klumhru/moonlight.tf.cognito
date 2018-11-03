resource "aws_cognito_identity_pool" "moonlight" {
  identity_pool_name               = "${var.project}_${var.tier}"
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id               = "${aws_cognito_user_pool_client.players.id}"
    provider_name           = "${aws_cognito_user_pool.moonlight.endpoint}"
    server_side_token_check = false
  }
}
