ARG BUILD_FROM
FROM ${BUILD_FROM}

# Define build arguments
ENV LANG C.UTF-8

# Install required packages
RUN apk add --no-cache \
    ffmpeg \
    nodejs \
    npm \
    python3 \
    make \
    g++ \
    curl \
    git

# Install n8n
RUN npm install n8n -g

# Copy local files
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
