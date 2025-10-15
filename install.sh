#!/bin/bash
set -e

PACKAGES=("$@")

if [ ${#PACKAGES[@]} -eq 0 ]; then
    echo "[ERROR] No packages specified."
    exit 1
fi

# Detect package manager
for manager in pkg apt-get apt dnf yum pacman; do
    if command -v "$manager" >/dev/null 2>&1; then
        PKG_MANAGER=$manager
        break
    fi
done

if [ -z "$PKG_MANAGER" ]; then
    echo "[ERROR] No supported package manager found!"
    exit 1
fi

# Function to check if a package is installed
is_installed() {
    local pkg=$1
    case $PKG_MANAGER in
        apt|apt-get|pkg) dpkg -s "$pkg" &>/dev/null ;;
        yum|dnf)         rpm -q "$pkg" &>/dev/null ;;
        pacman)          pacman -Qi "$pkg" &>/dev/null ;;
        *)               return 1 ;;
    esac
}

# Function to install a single package
install_pkg() {
    local pkg=$1
    echo "[INFO] Installing: $pkg"

    case $PKG_MANAGER in
        pkg)
            apt-get update -y >/dev/null
            apt-get install -y "$pkg" >/dev/null
            ;;
        apt|apt-get)
            sudo apt-get update -y >/dev/null
            sudo apt-get install -y "$pkg" >/dev/null
            ;;
        yum)
            sudo yum makecache -y >/dev/null
            sudo yum install -y "$pkg" >/dev/null
            ;;
        dnf)
            sudo dnf makecache -y >/dev/null
            sudo dnf install -y "$pkg" >/dev/null
            ;;
        pacman)
            sudo pacman -Syu --noconfirm >/dev/null 2>&1 || true
            sudo pacman -S --noconfirm --needed "$pkg" >/dev/null
            ;;
    esac

    echo "[SUCCESS] $pkg installed!"
}

# Main loop — check and install individually
for pkg in "${PACKAGES[@]}"; do
    if is_installed "$pkg"; then
        echo "[INFO] $pkg is already installed, skipping."
    else
        install_pkg "$pkg"
    fi
done
