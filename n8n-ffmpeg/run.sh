#!/usr/bin/with-contenv bashio

# Aguardar um pouco para o sistema estabilizar
sleep 2

# Ler configurações do Home Assistant
CONFIG_PATH=/data/options.json

# Definir configurações do n8n
export N8N_USER_FOLDER="/data"
export N8N_HOST="0.0.0.0"
export N8N_PORT="5678"
export N8N_PROTOCOL="http"

# Configurar autenticação básica se especificada nas opções
if bashio::config.true 'N8N_BASIC_AUTH_ACTIVE'; then
    export N8N_BASIC_AUTH_ACTIVE="true"
    export N8N_BASIC_AUTH_USER=$(bashio::config 'N8N_BASIC_AUTH_USER')
    export N8N_BASIC_AUTH_PASSWORD=$(bashio::config 'N8N_BASIC_AUTH_PASSWORD')
    bashio::log.info "Autenticação básica ativada para utilizador: ${N8N_BASIC_AUTH_USER}"
else
    export N8N_BASIC_AUTH_ACTIVE="false"
    bashio::log.info "Autenticação básica desativada"
fi

# Log de configurações
bashio::log.info "Iniciando n8n..."
bashio::log.info "Host: ${N8N_HOST}"
bashio::log.info "Porto: ${N8N_PORT}"
bashio::log.info "Pasta de dados: ${N8N_USER_FOLDER}"

# Configurar permissões
chown -R root:root /data
chmod -R 755 /data

# Aguardar a porta estar disponível
while ! nc -z localhost 5678; do
  sleep 1
done 2>/dev/null || true

# Iniciar n8n com logging
exec n8n start 2>&1