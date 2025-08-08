ARG BUILD_FROM=ghcr.io/home-assistant/aarch64-base:3.19
FROM ${BUILD_FROM}
# Variáveis de ambiente
ENV LANG=C.UTF-8
ENV N8N_USER_FOLDER="/data"

# Instalar dependências
RUN apk add --no-cache \
    ffmpeg \
    nodejs \
    npm \
    python3 \
    make \
    g++ \
    curl \
    git \
    bash

# Instalar n8n globalmente
RUN npm install n8n -g

# Criar diretório de dados
RUN mkdir -p /data

# Copiar script de inicialização
COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Expor porta
EXPOSE 5678

# Definir volume para dados
VOLUME ["/data"]

# Comando de inicialização
CMD ["/run.sh"]