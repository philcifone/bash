#!/bin/bash

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Installing Git..."
    
    # Install Git with confirmation
    sudo pacman -S --noconfirm git
    
    # Check if the installation was successful
    if [ $? -eq 0 ]; then
        echo "Git installation successful."
    else
        echo "Git installation failed. Please install it manually and rerun this script."
        exit 1
    fi
fi

# Install fakeroot, binutils, and make if not already installed
if ! command -v fakeroot &> /dev/null; then
    echo "fakeroot is not installed. Installing fakeroot..."
    sudo pacman -S --noconfirm fakeroot
fi

if ! command -v strip &> /dev/null; then
    echo "binutils (strip) is not installed. Installing binutils..."
    sudo pacman -S --noconfirm binutils
fi

if ! command -v make &> /dev/null; then
    echo "make is not installed. Installing make..."
    sudo pacman -S --noconfirm make
fi

# Clone the Yay repository
git clone https://aur.archlinux.org/yay.git

# Navigate to the Yay directory
cd yay

# Build and install Yay
makepkg -si

# Update Yay
yay -Syu

echo "Yay installation and update complete."

