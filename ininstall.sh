#!/bin/bash

set -e

SERVICE_NAME="thinkfan-gen.service"
SCRIPT_PATH="/usr/local/bin/thinkfan-gen.sh"
UNIT_PATH="/etc/systemd/system/$SERVICE_NAME"
CONFIG_FILE="/etc/thinkfan.conf"

echo "Stopping $SERVICE_NAME..."
sudo systemctl stop "$SERVICE_NAME" || echo "Service not running."

echo "Disabling $SERVICE_NAME..."
sudo systemctl disable "$SERVICE_NAME" || echo "Service not enabled."

echo "Removing script: $SCRIPT_PATH"
sudo rm -f "$SCRIPT_PATH"

echo "Removing systemd service unit: $UNIT_PATH"
sudo rm -f "$UNIT_PATH"

echo "Reloading systemd..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload

if [ -f "$CONFIG_FILE" ]; then
    read -rp "Do you want to remove the generated config file at $CONFIG_FILE? (y/N): " CONFIRM
    if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
        echo "Removing $CONFIG_FILE"
        sudo rm -f "$CONFIG_FILE"
    else
        echo "Skipping removal of $CONFIG_FILE"
    fi
fi

echo "✅ Uninstallation complete."
