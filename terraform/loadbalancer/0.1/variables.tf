variable "inputs" {
  type = any
}

variable "infra" {
  type = any
  default = {}
}

variable "cc_metadata" {
  type = any
  default = {}
}

variable "instance" {
  type = any
}

variable "instance_name" {
  type = string
  default = "test_instance"
}

variable "namespace" {
  type = string
  default = "default"
}
