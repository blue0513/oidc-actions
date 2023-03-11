locals {
  github_org_name = "blue0513"
  full_paths = ["repo:${local.github_org_name}/oidc-actions:*"]
}

provider "aws" {
  region = "ap-northeast-1"
}

# resource

resource "aws_iam_openid_connect_provider" "github_actions" {
  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.github_actions.certificates[0].sha1_fingerprint]
}

resource "aws_iam_role" "github_actions" {
  name               = "oidc-github-actions"
  assume_role_policy = data.aws_iam_policy_document.github_actions.json
  description        = "IAM Role for GitHub Actions OIDC"
}

# data

data "tls_certificate" "github_actions" {
  url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}

data "aws_iam_policy_document" "github_actions" {
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    principals {
      type = "Federated"
      identifiers = [
        aws_iam_openid_connect_provider.github_actions.arn
      ]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = local.full_paths
    }
  }
}
