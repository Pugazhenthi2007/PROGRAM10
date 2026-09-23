#!/bin/bash

# =====================================
# Swap Space Creation Script
# Student Name:
# Roll Number:
# =====================================

# Write your commands below

SWAPFILE="/swapfile"
SWAPSIZE="1G"

echo "Creating a $SWAPSIZE swap file at $SWAPFILE..."

# Allocate space for the swap file
sudo fallocate -l $SWAPSIZE $SWAPFILE || sudo dd if=/dev/zero of=$SWAPFILE bs=1M count=1024 status=progress

# Restrict permissions for security (root access only)
echo "Setting secure permissions..."
sudo chmod 600 $SWAPFILE

# Set up the swap area
echo "Formatting space as swap..."
sudo mkswap $SWAPFILE

# Activate the swap file
echo "Enabling swap file..."
sudo swapon $SWAPFILE

# Add to /etc/fstab for persistence across reboots
if ! grep -q "$SWAPFILE" /etc/fstab; then
    echo "Configuring automatic mount on boot in /etc/fstab..."
    echo "$SWAPFILE none swap defaults 0 0" | sudo tee -a /etc/fstab
fi

# Confirm creation
echo "Swap space setup complete! Active swap layout:"
sudo swapon --show
free -h
