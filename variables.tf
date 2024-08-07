variable "ami_id" {
    type = string
    default = "ami-0ff591da048329e00"
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
