# Use an official Node.js runtime as a parent image
FROM node:16

# Install required dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    python3 \
    curl \
    httpie \
    && rm -rf /var/lib/apt/lists/*

# Install Ungit globally
RUN npm install -g ungit

# Install ttyd
RUN curl -L https://github.com/tsl0922/ttyd/releases/download/1.6.3/ttyd.x86_64 \
    -o /usr/local/bin/ttyd && chmod +x /usr/local/bin/ttyd

# Set up directories for Ungit and ttyd
RUN mkdir /opit
WORKDIR /opit

# Expose ports for Ungit (8448) and ttyd (7681)
EXPOSE 8448 7681

# Start both Ungit and ttyd using a shell script
CMD ["sh", "-c", "ungit --port 8448 --no-b --git /opit & ttyd -p 7681 bash"]
