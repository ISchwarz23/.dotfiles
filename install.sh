#!/bin/bash
set -e

PACKAGES="$@"

echo "[INFO] Going to install $PACKAGES..."

if command -v pkg > /dev/null 2>&1; then
    echo "[DEBUG] Using pkg..."
    pkg update -y > /dev/null
    pkg install -y $PACKAGES > /dev/null
elif command -v apt > /dev/null 2>&1; then
    echo "[DEBUG] Using apt..."
    sudo apt-get update -y > /dev/null
    sudo apt-get install -y $PACKAGES > /dev/null
    sudo apt-get autoremove -y > /dev/null
elif command -v yum > /dev/null 2>&1; then
    echo "[DEBUG] Using yum..."
    sudo yum makecache -y > /dev/null
    sudo yum install -y $PACKAGES > /dev/null
    sudo yum autoremove -y > /dev/null || true  # some yum versions lack autoremove
elif command -v dnf > /dev/null 2>&1; then
    echo "[DEBUG] Using dnf..."
    sudo dnf makecache -y > /dev/null
    sudo dnf install -y $PACKAGES > /dev/null
    sudo dnf autoremove -y > /dev/null
elif command -v pacman > /dev/null 2>&1; then
    echo "[DEBUG] Using pacman..."
    sudo pacman -Syu --noconfirm > /dev/null 2>&1 || true
    sudo pacman -S --noconfirm --needed $PACKAGES > /dev/null
else
    echo "[ERROR] No supported package manager found!"
    exit 1
fi

echo "[SUCCESS] Installation complete!"
