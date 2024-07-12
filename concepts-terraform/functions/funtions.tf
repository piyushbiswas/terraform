

# variable "test" {
#   type = string
# }

# output "output" {
  
#   value = "first user is ${var.test}"
# }


# ////////////////////////////////////////////////////

# variable "test1" {
#   type = list
# }

# output "output1" {
  
#   value = "first user is ${var.test1[0]}"
# }

# /////////////////////////////////////////////////////
# variable "test2" {
#   type = number
# }

# output "output2" {
  
#   value = "first user is ${var.test2}"
# }

# ///////////////////////////////////////////////////////
# variable "function1" {
#   type = list
#   default = [ "kallu" , "pallu" , "jhallu" ]
# }

# output "out1" {
  
#   value = "first user is ${var.function1[0]}"
# }

# //////////////////////////////////////////////////////

# variable "function2" {
#   type = list
#   default = [ "kallu" , "pallu" , "jhallu" ]
# }

# output "out2" {
  
#   value = "print list of user seperated by comma  ${join(",",var.function2)}"
# }

//////////////////////////////////////////////////////////

# variable "function3" {
#   type = list
#   default = [ "kallu" , "pallu" , "jhallu" ]
# }

# output "out3" {
  
#   value = "print list of user Upper case  ${upper(var.function3[0])}"
# }


/////////////////////////////////////////////////////////

# variable "function4" {
#   type = list
#   default = [ "kallu" , "pallu" , "jhallu" ]
# }

# output "out4" {
  
#   value = "print list of user title case  ${title(var.function4[0])}"
# }

////////////////////////////////////////////////////////////

# variable "function5" {
#   type = map
#   default = {
#     piyush = 25
#     gourav = 40
#   }
# }

# output "out5" {
  
#   value = "my name is gourav and my age is ${lookup(var.function5,"gourav")} "
# }

///////////////////////////////////////////////////////////



variable "function5" {
  type = map
  default = {
    piyush = 25
    gourav = 40
  }
}

variable "username" {
    type = string
  
}

output "out5" {
  
  value = "my name is ${var.username} and my age is ${lookup(var.function5,"${var.username}")}"
}