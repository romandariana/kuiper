#!/bin/bash -e
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2026 Analog Devices, Inc.
# Author: Alisa-Dariana Roman <alisa.roman@analog.com>

# RPi5 config.txt
rm /boot/config.txt
install -m 644 /stages/07.extra-tweaks/01.extra-scripts/datax/config.txt /boot/config.txt

# Copy no-OS hardware access udev rules
echo "Installing udev rules for hardware access..."
cp /stages/07.extra-tweaks/01.extra-scripts/datax/50-noos-hardware.rules /etc/udev/rules.d

usermod -a -G spi,gpio,i2c analog

# Install VSCode
echo "Installing VSCode..."
wget -O vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-arm64"
apt-get install -y --no-install-recommends ./vscode.deb
rm vscode.deb

echo 'alias code="code --use-inmemory-secretstorage"' >> /etc/bash.bashrc

# Install npm (needed for Claude Code)
echo "Installing npm..."
apt-get install npm -y --no-install-recommends

# Secret Stuff

# Install WiFi connection profile
install -m 600 /stages/07.extra-tweaks/01.extra-scripts/datax/wificonn /etc/NetworkManager/system-connections/
