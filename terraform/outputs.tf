output "amplify_default_domain" {
  value = aws_amplify_app.app.default_domain
}

output "branch_url" {
  value = "https://${aws_amplify_branch.prod.branch_name}.${aws_amplify_app.app.default_domain}"
}
