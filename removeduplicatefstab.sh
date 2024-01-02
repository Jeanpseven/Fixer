#!/bin/bash

# Backup the original fstab file
sudo cp /etc/fstab /etc/fstab.bak

# Use awk to remove duplicate entries and overwrite the fstab file
awk '!x[$0]++' /etc/fstab > /tmp/fstab.tmp && sudo mv /tmp/fstab.tmp /etc/fstab

echo "Duplicate entries removed from /etc/fstab."