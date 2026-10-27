variable "project_id" {
  type        = string
  description = "ID del proyecto de GCP"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "prefix" {
  type        = string
  default     = "ucu-lab"
  description = "Prefijo de nombres (minúsculas, números y guiones)"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,14}$", var.prefix))
    error_message = "prefix: 3 a 15 caracteres [a-z0-9-], empezando con letra."
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

variable "machine_type" {
  type    = string
  default = "e2-micro"

  validation {
    condition     = contains(["e2-micro", "e2-small"], var.machine_type)
    error_message = "Solo se permiten tamaños pequeños: e2-micro o e2-small."
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

variable "subnet_cidr" {
  type    = string
  default = "10.10.1.0/24"
}
