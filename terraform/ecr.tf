resource "aws_ecr_repository" "angular_app" {
  name = "angular-app"
  image_scanning_configuration {
    scan_on_push = true
  }
  force_delete = true
}