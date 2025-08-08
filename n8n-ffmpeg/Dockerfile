# Usar imagem base Alpine padrão para evitar problemas de DNS
FROM alpine:3.19

# Variáveis de ambiente
ENV LANG=C.UTF-8
ENV N8N_USER_FOLDER="/data"

# Instalar s6-overlay para compatibilidade com Home Assistant
ADD https://github.com/just-containers/s6-overlay/releases/download/v3.1.6.2/s6-overlay-noarch.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v3.1.6.2/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz && \
    tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz && \
    rm -f /tmp/s6-overlay-*.tar.xz

# Atualizar repositórios e instalar dependências base
RUN apk update && apk upgrade && \
    apk add --no-cache \
    bash \
    ca-certificates \
    curl \
    git \
    nodejs \
    npm \
    python3 \
    make \
    g++ \
    ffmpeg \
    jq \
    tzdata && \
    rm -rf /var/cache/apk/*

# Instalar n8n
RUN npm install -g n8n@latest --unsafe-perm && \
    npm cache clean --force

# Criar diretórios necessários
RUN mkdir -p /data /etc/services.d/n8n

# Copiar script de inicialização
COPY run.sh /etc/services.d/n8n/run
RUN chmod +x /etc/services.d/n8n/run

# Configurar working directory
WORKDIR /data

# Expor porta
EXPOSE 5678

# Volume para dados persistentes
VOLUME ["/data"]

# Health check melhorado
HEALTHCHECK --interval=30s --timeout=10s --start-period=120s \
  CMD curl -f http://localhost:5678/healthz || curl -f http://localhost:5678 || exit 1

# Usar s6-overlay como init system
ENTRYPOINT ["/init"]