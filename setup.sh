#!/bin/bash

set -e

echo "Installing thinkfan-gen..."

# Copy the script
sudo cp thinkfan-gen.sh /usr/local/bin/thinkfan-gen.sh
sudo chmod +x /usr/local/bin/thinkfan-gen.sh

# Install the systemd service
sudo cp systemd/thinkfan-gen.service /etc/systemd/system/thinkfan-gen.service

# Reload systemd and enable the service
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable thinkfan-gen.service

# Optional: enable thinkfan if not done
sudo systemctl enable thinkfan.service

echo "Installation complete. Service will run on next boot."
