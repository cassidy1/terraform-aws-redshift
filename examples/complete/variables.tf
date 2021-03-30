variable "region" {
    default = "us-west-2"
}

variable "name" {
    default = "demo-redshift"
}

variable "cidr" {
    default = "10.10.0.0/16"
}

variable "azs" {
    default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "redshift_subnets" {
    default = ["10.10.41.0/24", "10.10.42.0/24", "10.10.43.0/24"]
}

variable "node_type" {
    default = "dc2.large"
}

variable "db_name" {
    default = "mydb"
}

variable "db_user" {
    default = "mydbuser"
}

variable "db_password" {
    default = "supersecurepassword"
}