# Use the existing ttyd image as the base
FROM tsl0922/ttyd:latest

# Install additional tools and dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    httpie \
    bash \
    nano \
    # Install Node.js (required for Ungit)
    && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    # Install Ungit globally
    && npm install -g ungit \
    # Clean up to reduce image size
    && rm -rf /var/lib/apt/lists/*

# Expose the ports for ttyd and Ungit
EXPOSE 7681 8448

# Set the working directory
WORKDIR /root

# Use tini for process management
ENTRYPOINT ["/usr/bin/tini", "--"]

# Start Ungit and ttyd with the given commands
CMD bash -c "ungit --port 8448 --no-b --git /root & ttyd -W bash"
