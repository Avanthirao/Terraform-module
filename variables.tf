variable "ami_id" {
    type = string
    default = "ami-0fda60cefceeaa4d3"
    description = "passing ami value to main"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
    description = "passing the values of inttance type"
  
}
variable "key" {
    type = string
    default = "ec2-key"
    description = "passing the values of inttance type"
  
}
