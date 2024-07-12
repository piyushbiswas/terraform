variable "vpc" {
    description = "prod level vpc"

}


variable "public_subnet_cidrs" {
  type = list(string)
  description = "Public CIDR range values"
  default = [ "10.0.1.0/24", "10.0.2.0/24" ]
}

variable "private_subnet_cidrs" {
  type = list(string)
  description = "Private Subnet CIDR valiues"
  default = [ "10.0.3.0/24", "10.0.4.0/24" ]
}

variable "availability_zone" {
    type = list(string)
    description = "Availabilty zones"
    default = [ "us-east-1a","us-east-1b" ]
  
}

variable "" {
  
}