
data "aws_iam_policy_document" "ecs-instance-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs-instance-role" {
  name               = "ecs-instance-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ecs-instance-policy.json
}

resource "aws_iam_role_policy_attachment" "ecs-instance-role-attachment" {
  role       = aws_iam_role.ecs-instance-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs-instance-profile" {
  name = "ecs-instance-profile"
  path = "/"
  role = aws_iam_role.ecs-instance-role.id
}

# Used by the ECS agent and Docker daemon to manage the containers on your behalf.
# This role provides the necessary permissions for ECS to pull container images from
# ECR (Elastic Container Registry), store logs in CloudWatch, and manage other necessary
# resources to run the containers. This role does not grant permissions to the application
# code itself but rather to the infrastructure that supports running that code. 
resource "aws_iam_role" "ecs_task_exec_role" {
  name = "ecs_task_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  inline_policy {
    name = "inline_policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "ecr:GetAuthorizationToken",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:GetRepositoryPolicy",
            "ecr:DescribeRepositories",
            "ecr:ListImages",
            "ecr:DescribeImages",
            "ecr:BatchGetImage",
            "ecr:GetLifecyclePolicy",
            "ecr:GetLifecyclePolicyPreview",
            "ecr:ListTagsForResource",
            "ecr:DescribeImageScanFindings",
            "logs:PutLogEvents",
            "logs:CreateLogStream",
            "logs:CreateLogGroup",
            "ssm:GetParameter*",
            "kms:Decrypt",
            "secretsmanager:GetSecretValue",
            "secretsmanager:DescribeSecret",
          ]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }
}

# This role is attached directly to an ECS task, granting the permissions necessary for the applications
# running inside the task's containers. The permissions assigned to this role enable the containers to
# interact with AWS services that the application might need to access.
resource "aws_iam_role" "ecs_task_role" {
  name = "ecs_task_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })

  # ssmmessages:CreateControlChannel
  # - Enables the establishment of a control channel for managing interactions and command signals between AWS Systems Manager and your resources.

  # ssmmessages:CreateDataChannel 
  # - Allows the creation of a data channel for transferring data between Systems Manager and your resources during sessions.

  # ssmmessages:OpenControlChannel 
  # - Permits the opening of an established control channel to start communications for session management.

  # ssmmessages:OpenDataChannel 
  # - Facilitates the opening of an established data channel to enable the transfer of data during active sessions with Systems Manager.

  inline_policy {
    name = "inline_policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow",
          Action = [
            "ssmmessages:CreateControlChannel",
            "ssmmessages:CreateDataChannel",
            "ssmmessages:OpenControlChannel",
            "ssmmessages:OpenDataChannel",
          ],
          Resource = "*"
        }
      ]
    })
  }
}
