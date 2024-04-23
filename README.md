# Terraform 2024

Create cloud infrastructure with Terraform.

## 🚀 Deployment

```bash
terraform init
terraform apply
```

## File Structure

- `develop` - Development environment
- `production` - Production environment
- `modules` - Terraform modules

## Useful AWS CLI Commands

- `terraform init` - Initialize the Terraform configuration
- `terraform init -upgrade` - Install the latest module and provider versions
- `terraform validate` - Check whether the configuration is valid
- `terraform plan` - Show changes required by the current configuration
- `terraform apply` - Create or update infrastructure
- `terraform destroy` - Destroy previously-created infrastructure

## Docker container

https://github.com/TomorrowTechReviews/aws-cdk-ts/tree/main/containers/chats

## Docker commands

Build on Apple Silicon M1:

```bash
docker buildx build --platform linux/amd64 -t chat .
```
