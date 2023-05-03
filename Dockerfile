# Start with official Ubuntu 20.04 LTS image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install necessary tools for testing scripts
RUN apt-get update \
  && apt-get install -y bash-completion command-not-found curl wget gnupg2 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Copy all .sh files from current directory to container
COPY *.sh /root/

# Set working directory
WORKDIR /root

# Set entrypoint to shell
ENTRYPOINT ["/bin/bash"]
