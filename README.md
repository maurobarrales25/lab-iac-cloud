# lab-iac-cloud — Lab Tema 6: red, VM y almacenamiento en la nube con IaC + pipeline

Elegí **una** nube y trabajá solo en su carpeta.

| Carpeta | Red | VM | Almacenamiento | Backend de estado |
|---|---|---|---|---|
| `aws/`   | VPC + subnet + IGW + SG | EC2 t3.micro (Amazon Linux 2023) | S3 + objeto | `s3` (use_lockfile) |
| `azure/` | VNet + subnet + NSG     | Linux VM B1s (Ubuntu 24.04)      | Storage Account + blob | `azurerm` |
| `gcp/`   | VPC + subnet + firewall | e2-micro (Debian 12)             | Cloud Storage + objeto | `gcs` |

```bash
# 1) completar <nube>/terraform.tfvars y <nube>/backend.hcl
# 2) desde tu máquina
TF_DIR=aws ./scripts/tf.sh plan
TF_DIR=aws ./scripts/tf.sh apply      # incluye smoke test HTTP
TF_DIR=aws ./scripts/tf.sh destroy
# 3) pipeline: .github/workflows/iac-cloud.yml  o  azure-pipelines.yml (cambiar TF_DIR)
```

Usar Terraform en lugar de OpenTofu: `TF_BIN=terraform`.

Versiones fijadas al preparar el material (oct-2026): aws `~> 6.0`, azurerm `~> 4.0`, google `~> 7.0`.
Ya existen azurerm 5.x y google 8.x: migrar de versión mayor queda como desafío.

**Al terminar: ejecutar destroy y borrar el bucket de estado.**
