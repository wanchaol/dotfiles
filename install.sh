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
  OS="macOS"
  INSTALLER="brew install"
  INSTALL_FD="brew install fd"
  INSTALL_STARSHIP="brew install starship"
  # INSTALL_NODE="brew install node"
  # Ensure Homebrew is installed
  if ! is_installed brew; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
elif [[ -f "/etc/os-release" ]] && grep -qi "ubuntu" /etc/os-release; then
  echo "Detected Ubuntu"
  OS="Ubuntu"
  INSTALLER="sudo apt install -y"
  INSTALL_FD="sudo apt install fd-find && ln -s $(which fdfind) ~/.local/bin/fd"
  INSTALL_STARSHIP="curl -sS https://starship.rs/install.sh | sh"
  # INSTALL_NODE=""
  sudo apt update
else
  echo "Unsupported OS"
  exit 1
fi

# Install necessary packages
install_package "zsh" "$INSTALLER zsh"
install_package "nvim" "$INSTALLER neovim"
install_package "rg" "$INSTALLER ripgrep"
install_package "fd" "$INSTALL_FD"
install_package "starship" "$INSTALL_STARSHIP"
install_package "uv" "curl -LsSf https://astral.sh/uv/install.sh | sh"

# Check if zsh is the default shell, if not, set it
if [[ "$SHELL" != *"zsh"* ]]; then
  echo "Changing default shell to zsh..."
  if [[ "$OS" == "macOS" ]]; then
    chsh -s "$(which zsh)"
    echo "Default shell changed to zsh. Please log out and log back in for changes to take effect."
  fi
else
  echo "zsh is already the default shell."
fi

# move configs to dst
cp zshrc ~/.zshrc
cp .tmux.conf ~/.tmux.conf
mkdir -p "~/.config"

cp -r config ~/.config

echo "Installation complete."
