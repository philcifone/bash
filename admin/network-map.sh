#!/bin/bash

# Define your local network range (adjust as needed)
local_network="192.168.1.0/24"

# Run an nmap scan to discover devices on the local network
nmap -sn $local_network | grep 'Nmap scan report' | awk '{print $5 $6}' > network_devices.txt

# Print the list of discovered devices
echo "Devices on the local network:"
cat network_devices.txt

# Clean up temporary files
rm network_devices.txt