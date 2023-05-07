# Start with official Ubuntu 20.04 LTS image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install necessary tools for testing scripts
RUN apt-get update \
  && apt-get install -y bash-completion command-not-found curl wget gnupg2 zsh git \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Set up default user and working directory
RUN useradd -m user \
  && chown -R user:user /root \
  && chsh -s /bin/bash user \
  && mkdir /home/user/scripts \
  && chown -R user:user /home/user

# Copy all script files from current directory to container
COPY *.sh /home/user/scripts

# Set working directory
WORKDIR /home/user/scripts

# Set entrypoint to shell
ENTRYPOINT ["/bin/bash"]
