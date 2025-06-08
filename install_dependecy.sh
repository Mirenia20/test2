#!/usr/bin/env bash

set -e

echo "Detecting distribution..."

# Identify the distro
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    echo "Cannot detect your Linux distribution."
    exit 1
fi

echo "Detected distribution: $DISTRO"

install_debian() {
    echo "Installing packages for Debian/Ubuntu..."
    sudo apt update
    sudo apt install -y \
        valac \
        blueprint-compiler \
        libgtk-4-dev \
        libpolkit-gobject-1-dev \
        libgee-0.8-dev \
        libadwaita-1-dev
}

install_arch() {
    echo "Installing packages for Arch Linux..."
    sudo pacman -Sy --noconfirm \
        vala \
        blueprint-compiler \
        gtk4 \
        polkit \
        libgee \
        libadwaita
}

install_fedora() {
    echo "Installing packages for Fedora..."
    sudo dnf install -y \
        vala \
        blueprint-compiler \
        gtk4-devel \
        polkit-devel \
        libgee-devel \
        libadwaita-devel
}

case "$DISTRO" in
    debian|ubuntu)
        install_debian
        ;;
    arch)
        install_arch
        ;;
    fedora)
        install_fedora
        ;;
    *)
        echo "Unsupported distribution: $DISTRO"
        exit 1
        ;;
esac

echo "All dependencies including valac and blueprint-compiler installed successfully."

