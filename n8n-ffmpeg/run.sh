#!/usr/bin/env bash
set -e

# Definir configurações do n8n
export N8N_USER_FOLDER="/data"
export N8N_HOST="${N8N_HOST:-0.0.0.0}"
export N8N_PORT="${N8N_PORT:-5678}"
export N8N_PROTOCOL="${N8N_PROTOCOL:-http}"

# Configurar autenticação básica se especificada
if [[ -n "${N8N_BASIC_AUTH_ACTIVE}" ]] && [[ "${N8N_BASIC_AUTH_ACTIVE}" == "true" ]]; then
    export N8N_BASIC_AUTH_USER="${N8N_BASIC_AUTH_USER:-admin}"
    export N8N_BASIC_AUTH_PASSWORD="${N8N_BASIC_AUTH_PASSWORD:-admin}"
fi

echo "Iniciando n8n..."
echo "Host: ${N8N_HOST}"
echo "Port: ${N8N_PORT}"
echo "User folder: ${N8N_USER_FOLDER}"

# Iniciar n8n
exec n8n