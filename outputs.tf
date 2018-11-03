output "user_pool_id" {
  value = "${aws_cognito_user_pool.moonlight.id}"
}

output "identity_pool_id" {
  value = "${aws_cognito_identity_pool.moonlight.id}"
}
