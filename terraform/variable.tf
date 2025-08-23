variable "aws_region" {
  default = "us-east-1"
}

variable "app_name" {
  type    = string
  default = "pwa-on-amplify"
}

variable "github_repo_url" {
  type    = string
   default = "https://github.com/shrey02802/Progressive-Web-App--PWA--Hosting-with-Amplify.git"
}


variable "github_branch" {
  type    = string
  default = "main"
}

variable "github_token" {
  type      = string
  default = "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"
}

variable "env_vars" {
  type    = map(string)
  default = {}
}

variable "use_vue" {
  type    = bool
  default = false # true for Vue, false for React
}

variable "custom_domain" {
  type    = string
  default = ""
}
   # optional
