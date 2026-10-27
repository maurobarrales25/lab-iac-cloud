variable "location" {
  type    = string
  default = "eastus"
}

variable "prefix" {
  type        = string
  default     = "ucu-lab"
  description = "Prefijo de nombres (minúsculas, números y guiones)"

  validation {
    condition     = can(regex("^[a-z0-9-]{3,12}$", var.prefix))
    error_message = "prefix: 3 a 12 caracteres [a-z0-9-]."
  }
}

variable "environment" {
  type    = string
  default = "dev"

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "environment debe ser dev o prod."
  }
}

variable "owner" {
  type        = string
  description = "Responsable (etiqueta obligatoria)"

  validation {
    condition     = can(regex("^[A-Za-z0-9-]{3,30}$", var.owner))
    error_message = "owner: 3 a 30 caracteres [A-Za-z0-9-]."
  }
}

variable "mensaje" {
  type        = string
  default     = "Hola desde IaC"
  description = "Texto que muestra la página web"
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"

  validation {
    condition     = contains(["Standard_B1s", "Standard_B2ats_v2", "Standard_B2s"], var.vm_size)
    error_message = "Solo se permiten tamaños pequeños: Standard_B1s, Standard_B2ats_v2 o Standard_B2s."
  }
}

variable "ssh_public_key" {
  type        = string
  description = "Clave pública SSH (Azure exige una; no se abre el puerto 22)"

  validation {
    condition     = can(regex("^ssh-rsa ", var.ssh_public_key))
    error_message = "Usar una clave RSA: ssh-keygen -t rsa -b 4096."
  }
}

variable "allowed_cidr" {
  type        = string
  default     = "0.0.0.0/0"
  description = "Origen permitido hacia el puerto 80"

  validation {
    condition     = can(cidrhost(var.allowed_cidr, 0))
    error_message = "allowed_cidr debe ser un CIDR válido, por ejemplo 203.0.113.10/32."
  }
}

variable "vnet_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "subnet_cidr" {
  type    = string
  default = "10.10.1.0/24"
}
