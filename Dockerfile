# Use Ubuntu as the base image
FROM ubuntu:latest


# Set the root password for the container
ENV root_password root
RUN echo 'root:${root_password}' | chpasswd

# Set non-interactive frontend (to avoid some prompts)
ARG DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y software-properties-common apt-transport-https wget

# Add the Microsoft GPG key
RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.gpg

# Add the Visual Studio Code repository
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" | tee /etc/apt/sources.list.d/vscode.list

# Install needed packages on your IDE system
RUN apt-get update && apt-get install -y code
RUN apt-get -y install sudo -y nano git curl wget unzip npm ssh
RUN apt-get update && apt-get install -y python3
RUN apt-get update && apt-get install -y python3-pip
RUN apt-get update && apt-get install -y tzdata
RUN apt-get update && apt-get install -y gdb
RUN apt-get update && apt-get install -y locales


# Set the timezone to China Standard Time
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Copy requirements.txt and install Python dependencies
COPY requirements.txt .
RUN pip3 install -r requirements.txt


# Generate Chinese locale
RUN locale-gen zh_CN.UTF-8

# Set environment variables
ENV LANG zh_CN.UTF-8
ENV LANGUAGE zh_CN:zh



# Switch to the root user
USER root

# Set the home directory for the non-root user
ENV HOME /root

# Expose the port for VS Code
ENV PORT 8553
EXPOSE $PORT


# Set the working directory
ENV WORKSPACE /workspace


# token_to_define is a placeholder for the connection token
ENV token_to_define caijiahao


# Start Visual Studio Code on port $PORT from anywhere (0.0.0.0)
CMD code serve-web --host 0.0.0.0 --port $PORT  --without-connection-token  --accept-server-license-terms --user-data-dir $HOME --extensions-dir  $HOME/extensions  --server-data-dir $HOME/server  --log info
