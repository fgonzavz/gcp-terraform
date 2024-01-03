variable "name" {
  default = "cluster-proyecto-final-kubernetes"
}
variable "project" {
  default = "proyecto-final-gcp-410014"
}

variable "location" {
  default = "us-central1-f"
}

variable "initial_node_count" {
  default = 1
}

variable "machine_type" {
  default = "n1-standard-2"
}
