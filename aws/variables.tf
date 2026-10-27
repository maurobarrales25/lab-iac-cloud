variable "region" {
  type    = string
  default = "us-east-1"
}

variable "prefix" {
  type        = string
  default     = "ucu-lab"
  description = "Prefijo de nombres (minúsculas, números y guiones)"

  validation {
    condition     = can(regex("^[a-z0-9-]{3,15}$", var.prefix))
    error_message = "prefix: 3 a 15 caracteres [a-z0-9-]."
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

variable "instance_type" {
  type    = string
  default = "t3.micro"

  validation {
    condition     = contains(["t3.micro", "t2.micro", "t3.small"], var.instance_type)
    error_message = "Solo se permiten tamaños pequeños: t3.micro, t2.micro o t3.small."
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

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "subnet_cidr" {
  type    = string
  default = "10.10.1.0/24"
}
