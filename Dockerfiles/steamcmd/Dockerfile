# Base image
FROM cryptton2004/ubuntu18

ARG DEBIAN_FRONTEND=noninteractive
	
ENV CHOWN_DIRS "/app,/steamcmd"

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        lib32gcc1 \
        libstdc++6 && \
    apt-get clean && \
    rm -rf \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        /tmp/*

# Fix issues with libcurl and steamcmd
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        libcurl4-openssl-dev:i386 && \
    ls -la /usr/lib/*/libcurl.so* && \
    ln -sf /usr/lib/i386-linux-gnu/libcurl.so.4 /usr/lib/i386-linux-gnu/libcurl.so && \
    ln -sf /usr/lib/i386-linux-gnu/libcurl.so.4 /usr/lib/i386-linux-gnu/libcurl.so.3 && \
    apt-get clean && \
    rm -rf \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        /tmp/*
		
# Install steamcmd
RUN mkdir -p /steamcmd && \
    curl -s http://media.steampowered.com/installer/steamcmd_linux.tar.gz \
    | tar -v -C /steamcmd -zx && \
    chmod +x /steamcmd/steamcmd.sh && \
    /steamcmd/steamcmd.sh +login anonymous +quit
	

# Default Node.js version
ARG NODE_VERSION=15

# Install dependencies and verify that Node.js is working
RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash - && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    nodejs \
    python-dev \
    jq \
    build-essential && \
    node -v && npm -v && \
    apt-get clean && \
    rm -rf \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        /tmp/*

# Update npm to the latest version
RUN npm install npm@latest -g

# Validate the Node.js version
RUN bash -c 'if [[ $(node -v) != v$NODE_VERSION* ]]; then echo "Incorrect Node.js version detected: $(node -v) (expected v${NODE_VERSION}.*)"; exit 1; fi'

# Add Node.js initialization script
ADD Scripts/nodejs_init.sh /nodejs_init.sh
RUN chmod +x /nodejs_init.sh

# Run the Node.js initialization script as the default command
CMD ["/bin/bash", "/nodejs_init.sh"]