#!/bin/bash

# Function to check if a package is installed
is_installed() {
    command -v "$1" &>/dev/null
}

# Install package if not already installed
install_package() {
    local package_name=$1
    local install_cmd=$2

    if is_installed "$package_name"; then
        echo "$package_name is already installed. Skipping..."
    else
        echo "Installing $package_name..."
        eval "$install_cmd"
    fi
}

# Detect OS
if [[ "$(uname)" == "Darwin" ]]; then
    echo "Detected macOS"
    INSTALLER="brew install"
    INSTALL_WEZTERM="brew install --cask wezterm"
    # Ensure Homebrew is installed
    if ! is_installed brew; then
        echo "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
elif [[ -f "/etc/os-release" ]] && grep -qi "ubuntu" /etc/os-release; then
    echo "Detected Ubuntu"
    INSTALLER="sudo apt-get install -y"
    INSTALL_WEZTERM="sudo apt install wezterm"
    sudo apt update
else
    echo "Unsupported OS"
    exit 1
fi

# Install necessary packages
install_package "nvim" "$INSTALLER neovim"
install_package "rg" "$INSTALLER ripgrep"
install_package "zsh" "$INSTALLER zsh"
install_package "wezterm" "$INSTALL_WEZTERM"
install_package "starship" "$INSTALLER starship"

# Check if zsh is the default shell, if not, set it
if [[ "$SHELL" != *"zsh"* ]]; then
    echo "Changing default shell to zsh..."
    chsh -s "$(which zsh)"
    echo "Default shell changed to zsh. Please log out and log back in for changes to take effect."
else
    echo "zsh is already the default shell."
fi

# move configs to dst
cp "zshrc" "~/.zshrc"
mkdir -p "~/.config"
cp -r "config/" "~/.config/"

echo "Installation complete."
