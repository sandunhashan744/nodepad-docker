# Use the latest Ubuntu image as the base
FROM ubuntu:latest

# Set environment variables for X server
ENV DISPLAY=host.docker.internal:0.0

# Install necessary packages including wine and Xvfb
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y wine32 xauth xvfb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a directory to store the installer
RUN mkdir /installer

# Copy the Notepad++ installer to the image
COPY npp.7.8.Installer.exe /installer/

# Set up the virtual display
CMD Xvfb :0 -screen 0 1024x768x16 -ac &

# Install Notepad++ using Wine
RUN wine /installer/npp.7.8.Installer.exe /S

# Set the entry point to start Notepad++
ENTRYPOINT ["wine", "/root/.wine/drive_c/Program Files/Notepad++/notepad++.exe"]
