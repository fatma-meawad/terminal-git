# Use the existing ttyd image as the base
FROM tsl0922/ttyd:latest

# Install additional tools
# Install additional tools and dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    httpie \
    bash \
    nano \
    && rm -rf /var/lib/apt/lists/*
# Copy the custom entrypoint script into the container

EXPOSE 7681
WORKDIR /root

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["ttyd", "-W", "bash"]
