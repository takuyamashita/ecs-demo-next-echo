resource "aws_iam_role" "github_actions" {
  name_prefix        = "github-actions-"
  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role.json
}

data "aws_iam_policy_document" "github_actions_assume_role" {

  // https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services#configuring-the-role-and-trust-policy

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_actions.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:takuyamashita/ecs-demo-next-echo:environment:PRODUCTION"]
    }

    #condition {
    #  test     = "StringEquals"
    #  variable = "token.actions.githubusercontent.com:sub"
    #  values   = ["repo:takuyamashita/ecs-demo-next-echo:ref:refs/heads/main"]
    #}

    #condition {
    #  test     = "StringLike"
    #  variable = "token.actions.githubusercontent.com:sub"
    #  values   = ["repo:takuyamashita/ecs-demo-next-echo:*"]
    #}
  }
}

resource "aws_iam_role_policy" "github_actions_use_push_image" {
  name_prefix = "github-actions-use-push-image-"
  role        = aws_iam_role.github_actions.name

  policy = data.aws_iam_policy_document.github_actions_push_image.json
}

data "aws_iam_policy_document" "github_actions_push_image" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:CompleteLayerUpload",
      "ecr:GetAuthorizationToken",
      "ecr:UploadLayerPart",
      "ecr:InitiateLayerUpload",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
    ]
    resources = ["*"]
  }

}

resource "aws_iam_role_policy" "github_actions_use_ssm" {
  name_prefix = "github-actions-use-ssm-"
  role        = aws_iam_role.github_actions.name

  policy = data.aws_iam_policy_document.github_actions_use_ssm.json
}

data "aws_iam_policy_document" "github_actions_use_ssm" {
  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "github_actions_use_deploy" {
  name_prefix = "github-actions-use-deploy-"
  role        = aws_iam_role.github_actions.name

  policy = data.aws_iam_policy_document.github_actions_deploy.json
}

data "aws_iam_policy_document" "github_actions_deploy" {
  statement {
    effect = "Allow"
    actions = [
      "ecs:RegisterTaskDefinition",
      "ecs:UpdateService",
      "ecs:DescribeServices",
      "ecs:DescribeTaskDefinition",
      "codedeploy:CreateDeployment",
      "codedeploy:GetApplication",
      "codedeploy:GetApplicationRevision",
      "codedeploy:GetDeployment",
      "codedeploy:GetDeploymentConfig",
      "codedeploy:GetDeploymentGroup",
      "iam:PassRole",
    ]
    resources = ["*"]
  }

}
