#!/usr/bin/env bash
# Punto único de entrada: lo usan la persona en su terminal y el pipeline.
# Uso: TF_DIR=aws ./scripts/tf.sh plan|apply|destroy
set -euo pipefail

ACTION="${1:?Uso: tf.sh plan|apply|destroy}"
DIR="${TF_DIR:?Definir TF_DIR=aws|azure|gcp}"
TF="${TF_BIN:-tofu}"                       # TF_BIN=terraform para usar Terraform
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

cd "${ROOT}/${DIR}"
echo ">> ${TF} ${ACTION} en ${DIR}/"

"${TF}" fmt -check -recursive
"${TF}" init -input=false -backend-config=backend.hcl
"${TF}" validate

case "${ACTION}" in
  plan)
    "${TF}" plan -input=false
    ;;
  apply)
    "${TF}" plan -input=false -out=tfplan
    "${TF}" apply -input=false tfplan
    "${ROOT}/scripts/smoke-test.sh" "$("${TF}" output -raw web_url)" "Entorno: dev"
    ;;
  destroy)
    "${TF}" destroy -input=false -auto-approve
    ;;
  *)
    echo "Acción desconocida: ${ACTION}" >&2
    exit 1
    ;;
esac
