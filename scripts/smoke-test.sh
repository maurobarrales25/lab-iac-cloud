#!/usr/bin/env bash
# Prueba de humo: la VM responde por HTTP con el texto esperado.
# La VM tarda 1 a 3 minutos en instalar nginx, por eso se reintenta.
set -euo pipefail
URL="${1:?url}"
EXPECTED="${2:?texto esperado}"

for i in $(seq 1 30); do
  if curl -fsS --max-time 5 "${URL}" | grep -q "${EXPECTED}"; then
    echo "OK: ${URL} responde y contiene '${EXPECTED}'"
    exit 0
  fi
  echo "Intento ${i}/30: todavía no responde, esperando 10 s..."
  sleep 10
done
echo "FALLO: ${URL} no respondió como se esperaba" >&2
exit 1
