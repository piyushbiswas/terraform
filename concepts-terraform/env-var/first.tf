variable "username" {
  type = string
}

output "printname" {
  value = "hello , ${var.username}"
}





/*

note:


to use env variable wee have to do 

1. export the varible like 

TF_VAR_username= hinal
  
*/