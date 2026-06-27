variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
}

variable "acr_name" {
  description = "Azure Container Registry Name"
  type        = string
}

variable "aks_name" {
  description = "AKS Cluster Name"
  type        = string
}

variable "node_count" {
  description = "Number of AKS Nodes"
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "AKS VM Size"
  type        = string
  default     = "Standard_B2s_V2"
}

variable "student_name" {
  description = "Student Name"
  type        = string
}