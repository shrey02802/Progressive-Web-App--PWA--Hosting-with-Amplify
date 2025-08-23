provider "aws" {
  region = var.aws_region
}

resource "aws_amplify_app" "app" {
  name         = var.app_name
  repository   = var.github_repo_url
  access_token = var.github_token
  platform     = "WEB"

  build_spec = <<-EOT
    version: 1
    frontend:
      phases:
        preBuild:
          commands:
            - npm ci
        build:
          commands:
            - npm run build
      artifacts:
        baseDirectory: build
        files:
          - '**/*'
      cache:
        paths:
          - node_modules/**/*
    appRoot:  my-pwa
  EOT


  enable_branch_auto_build    = true
  enable_branch_auto_deletion = true
  environment_variables       = var.env_vars

  # SPA rewrite so routes like /dashboard work
  custom_rule {
    source = "/<*>"
    target = "/index.html"
    status = "200"
  }
}

resource "aws_amplify_branch" "prod" {
  app_id            = aws_amplify_app.app.id
  branch_name       = var.github_branch
  stage             = "PRODUCTION"
  enable_auto_build = true
}

resource "aws_amplify_webhook" "trigger" {
  app_id      = aws_amplify_app.app.id
  branch_name = aws_amplify_branch.prod.branch_name
  description = "Manual build trigger"
}

resource "aws_amplify_domain_association" "domain" {
  count       = length(var.custom_domain) > 0 ? 1 : 0
  app_id      = aws_amplify_app.app.id
  domain_name = var.custom_domain
  sub_domain {
    branch_name = aws_amplify_branch.prod.branch_name
    prefix      = "" # apex; use "www" if you want www.<domain>
  }
}
