variable "age" {
  type = number
}

variable "username" {
  type = string
}

output "output" {
  value = "hello ${var.username} , your age is ${var.age}"
}