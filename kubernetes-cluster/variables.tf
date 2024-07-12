variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "ports_to_be_open" {
  type = list(number)
}

variable "number_of_worker" {
        description = "number of worker instances to be join on cluster."
        default = 2
}