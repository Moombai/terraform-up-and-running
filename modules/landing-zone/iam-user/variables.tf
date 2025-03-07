variable "user_name" {
  description = "The user name to use"
  type        = string
}

output "user_arn" {
  value       = aws_iam_user.example.arn
  description = "The ARN of the created user"
}
