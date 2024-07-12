///variable read from user to give input 

variable "username" {

}

output "printname" {

  value = var.username
}


output "aa" {

  value = " hello ,${var.username} , good morning"
}

// string k sath aise dena h putput k liye

output "greet" {

  value = " hello ,${var.username} , good morning"
}


output "a" {

  value = " hello ,${var.username} , good morning"
}


/////alphabetic order m hi print kiya same output ki values



///////////////////////////////////////////////////////////////////////////////////

variable "age" {

  type    = number //number only will be taken as input
#   default = "10"
}


output "age" {

  value = " hello ,${var.username} , good morning,your age is ${var.age}"
}

//////////////////////////////////////////////////////////////////


variable "users" {
  
  type = list
}

output "print-input-numbered-value-from-list" {
  value = var.users[0]
}