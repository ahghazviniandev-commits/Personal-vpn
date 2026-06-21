#!/bin/bash

# Must run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root."
  exit 1
fi

# Check if RTT is already running
if pgrep -x "RTT" > /dev/null; then
  echo "Tunnel is running! Stop it before updating."
  echo "Run: pkill RTT"
  exit 1
fi

echo "Updating package lists..."
apt update -y

# Install required packages
echo "Installing dependencies..."
apt install -y unzip wget lsof

echo ""
echo "Downloading ReverseTlsTunnel..."
echo ""

# Detect architecture
ARCH=$(uname -m)

case "$ARCH" in
  x86_64)
    URL="https://github.com/radkesvat/ReverseTlsTunnel/releases/download/V6.9/v6.9_linux_amd64.zip"
    FILE="v6.9_linux_amd64.zip"
    ;;
  arm|aarch64)
    URL="https://github.com/radkesvat/ReverseTlsTunnel/releases/download/V6.9/v6.9_linux_arm64.zip"
    FILE="v6.9_linux_arm64.zip"
    ;;
  *)
    echo "Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

# Download
wget -O "$FILE" "$URL"

# Extract
unzip -o "$FILE"

# Make executable
chmod +x RTT

# Cleanup
rm "$FILE"

echo ""
echo "ReverseTlsTunnel installation finished."
echo ""
