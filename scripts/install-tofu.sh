#!/usr/bin/env bash
# Instala OpenTofu desde el binario oficial y verifica su checksum SHA-256.
# Uso: ./scripts/install-tofu.sh 1.12.6
set -euo pipefail

VERSION="${1:?Uso: install-tofu.sh <version>  (ej.: 1.12.6)}"
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"          # linux | darwin
case "$(uname -m)" in
  x86_64)        ARCH="amd64" ;;
  aarch64|arm64) ARCH="arm64" ;;
  *) echo "Arquitectura no soportada: $(uname -m)" >&2; exit 1 ;;
esac

BASE_URL="https://github.com/opentofu/opentofu/releases/download/v${VERSION}"
ZIP="tofu_${VERSION}_${OS}_${ARCH}.zip"
SUMS="tofu_${VERSION}_SHA256SUMS"
BIN_DIR="${HOME}/.local/bin"

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT
cd "$WORK"

echo ">> Descargando ${ZIP}"
curl -fsSLO "${BASE_URL}/${ZIP}"
curl -fsSLO "${BASE_URL}/${SUMS}"

echo ">> Verificando checksum"
if command -v sha256sum >/dev/null 2>&1; then
  grep " ${ZIP}\$" "${SUMS}" | sha256sum -c -
else
  grep " ${ZIP}\$" "${SUMS}" | shasum -a 256 -c -       # macOS
fi

unzip -q -o "${ZIP}" tofu
mkdir -p "${BIN_DIR}"
install -m 0755 tofu "${BIN_DIR}/tofu"

# Agregar al PATH de los pasos siguientes según la plataforma CI
if [[ -n "${GITHUB_PATH:-}" ]]; then
  echo "${BIN_DIR}" >> "${GITHUB_PATH}"                 # GitHub Actions
elif [[ -n "${TF_BUILD:-}" ]]; then
  echo "##vso[task.prependpath]${BIN_DIR}"              # Azure DevOps
fi

"${BIN_DIR}/tofu" version
