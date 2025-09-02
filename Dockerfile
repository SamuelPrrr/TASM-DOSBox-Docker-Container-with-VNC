FROM ubuntu:22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    dosbox \
    wget \
    curl \
    unzip \
    x11vnc \
    xvfb \
    fluxbox \
    supervisor \
    xterm \
    wmctrl \
    x11-utils \
    && rm -rf /var/lib/apt/lists/*

# Create directories for DOS environment and logs
RUN mkdir -p /dos/tasm /dos/pens /dos/workspace /root/.dosbox /var/log/supervisor

# Copy TASM files from local directory (if they exist)
COPY tasm/ /dos/tasm/

# Create a script to setup the workspace
RUN echo '#!/bin/bash' > /setup-workspace.sh && \
    echo 'cp /dos/tasm/TASM.EXE /dos/workspace/' >> /setup-workspace.sh && \
    echo 'cp /dos/tasm/TLINK.EXE /dos/workspace/' >> /setup-workspace.sh && \
    echo 'cp /dos/tasm/TD.EXE /dos/workspace/' >> /setup-workspace.sh && \
    chmod +x /setup-workspace.sh

# Create a readme for TASM usage
RUN echo "TASM Environment Setup" > /dos/tasm/INFO.txt && \
    echo "=====================" >> /dos/tasm/INFO.txt && \
    echo "If TASM files are missing, run: scripts/download-tasm.sh" >> /dos/tasm/INFO.txt && \
    echo "Required files: TASM.EXE, TLINK.EXE" >> /dos/tasm/INFO.txt

# Set up DOSBox configuration
COPY config/dosbox.conf /root/.dosbox/dosbox-0.74-3.conf

# Create startup script
COPY scripts/start-dosbox.sh /start-dosbox.sh
RUN chmod +x /start-dosbox.sh

# Create supervisor configuration
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose VNC port
EXPOSE 5900

# Set working directory
WORKDIR /dos/pens

# Start supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
