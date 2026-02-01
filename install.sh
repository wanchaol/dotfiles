#!/bin/bash

# Function to check if a package is installed
is_installed() {
  command -v "$1" &>/dev/null
}

# Install zsh
install_zsh() {
  if is_installed "zsh"; then
    echo "zsh is already installed. Skipping..."
  else
    echo "Installing zsh..."
    $INSTALLER zsh
  fi
}

# Install ripgrep
install_ripgrep() {
  if is_installed "rg"; then
    echo "ripgrep is already installed. Skipping..."
  else
    echo "Installing ripgrep..."
    $INSTALLER ripgrep
  fi
}

# Install fd
install_fd() {
  if is_installed "fd"; then
    echo "fd is already installed. Skipping..."
  else
    echo "Installing fd..."
    if [[ "$OS" == "macOS" ]]; then
      brew install fd
    elif [[ "$OS" == "Ubuntu" ]]; then
      sudo apt install -y fd-find
      ln -s $(which fdfind) ~/.local/bin/fd
    fi
  fi
}

install_zimfw() {
  if is_installed "zimfw"; then
    echo "zimfw is already installed. Skipping..."
  else
    echo "Installing zimfw..."
    curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
  fi
}

# Install helix
install_helix() {
  if is_installed "hx"; then
    echo "helix is already installed. Skipping..."
  else
    echo "Installing helix..."
    if [[ "$OS" == "macOS" ]]; then
      brew install helix
    elif [[ "$OS" == "Ubuntu" ]]; then
      HELIX_VERSION="25.07.1"
      HELIX_ARCH="$(uname -m)-linux"
      HELIX_DIR="$HOME/.local/helix_${HELIX_VERSION}"
      TARBALL="helix-${HELIX_VERSION}-${HELIX_ARCH}.tar.xz"

      curl -LO "https://github.com/helix-editor/helix/releases/download/${HELIX_VERSION}/${TARBALL}"
      rm -rf "$HELIX_DIR"
      mkdir -p "$HELIX_DIR"
      tar -xJf "$TARBALL" -C "$HELIX_DIR" --strip-components=1
      rm "$TARBALL"
      echo "Helix installed to: $HELIX_DIR"
      mkdir -p "$HOME/.local/bin"
      ln -sf "$HELIX_DIR/hx" "$HOME/.local/bin/hx"

      # Copy runtime directory for Ubuntu
      mkdir -p ~/.config/helix
      if [[ -d "$HELIX_DIR/runtime" ]]; then
        cp -r "$HELIX_DIR/runtime" ~/.config/helix/runtime
        echo "Helix runtime copied to ~/.config/helix/runtime"
      fi
    fi
  fi
}

# Install uv (macOS only)
install_uv() {
  if [[ "$OS" == "macOS" ]]; then
    if is_installed "uv"; then
      echo "uv is already installed. Skipping..."
    else
      echo "Installing uv..."
      curl -LsSf https://astral.sh/uv/install.sh | sh
    fi
  fi
}

# Detect OS
if [[ "$(uname)" == "Darwin" ]]; then
  echo "Detected macOS"
  OS="macOS"
  INSTALLER="brew install"
  # Ensure Homebrew is installed
  if ! is_installed brew; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
elif [[ -f "/etc/os-release" ]] && grep -qi "ubuntu" /etc/os-release; then
  echo "Detected Ubuntu"
  OS="Ubuntu"
  INSTALLER="sudo apt install -y"
  sudo apt update
else
  echo "Unsupported OS"
  exit 1
fi

# Install necessary packages
install_zsh
install_zimfw
install_ripgrep
install_fd
install_helix
install_uv

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

# submodule init for dotfiles repo (i.e. init the tmux plugin)
git submodule update --init --recursive

cp zshrc ~/.zshrc
cp .gitconfig ~/.gitconfig
cp zshenv ~/.zshenv

cp .tmux.conf ~/.tmux.conf
mkdir -p "~/.config"

cp -a config/. ~/.config

echo "Installation complete."
