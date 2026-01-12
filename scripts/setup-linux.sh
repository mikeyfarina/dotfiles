#!/usr/bin/env bash
# =============================================================================
# Linux / Codespaces Setup
# =============================================================================

set -e

log_info() { echo -e "\033[0;34m[INFO]\033[0m $1"; }
log_success() { echo -e "\033[0;32m[OK]\033[0m $1"; }

# -----------------------------------------------------------------------------
# Install essential CLI tools via apt
# -----------------------------------------------------------------------------
install_apt_packages() {
    log_info "Installing packages via apt..."

    sudo apt-get update -qq

    # Core tools
    sudo apt-get install -y -qq \
        zsh \
        curl \
        wget \
        git \
        unzip \
        jq \
        tree \
        htop \
        2>/dev/null

    log_success "apt packages installed"
}

# -----------------------------------------------------------------------------
# Install modern CLI tools
# -----------------------------------------------------------------------------
install_modern_tools() {
    # Install eza (modern ls)
    if ! command -v eza &>/dev/null; then
        log_info "Installing eza..."
        sudo mkdir -p /etc/apt/keyrings
        wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg 2>/dev/null || true
        echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list >/dev/null
        sudo apt-get update -qq
        sudo apt-get install -y -qq eza 2>/dev/null || log_info "eza install skipped (may not be available)"
    fi

    # Install bat (modern cat)
    if ! command -v bat &>/dev/null && ! command -v batcat &>/dev/null; then
        log_info "Installing bat..."
        sudo apt-get install -y -qq bat 2>/dev/null || true
        # Ubuntu/Debian uses 'batcat' name
        if command -v batcat &>/dev/null; then
            mkdir -p ~/.local/bin
            ln -sf "$(which batcat)" ~/.local/bin/bat
        fi
    fi

    # Install fd (modern find)
    if ! command -v fd &>/dev/null && ! command -v fdfind &>/dev/null; then
        log_info "Installing fd..."
        sudo apt-get install -y -qq fd-find 2>/dev/null || true
        if command -v fdfind &>/dev/null; then
            mkdir -p ~/.local/bin
            ln -sf "$(which fdfind)" ~/.local/bin/fd
        fi
    fi

    # Install ripgrep
    if ! command -v rg &>/dev/null; then
        log_info "Installing ripgrep..."
        sudo apt-get install -y -qq ripgrep 2>/dev/null || true
    fi

    # Install fzf
    if ! command -v fzf &>/dev/null; then
        log_info "Installing fzf..."
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf 2>/dev/null || true
        ~/.fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish 2>/dev/null || true
    fi

    # Install zoxide
    if ! command -v zoxide &>/dev/null; then
        log_info "Installing zoxide..."
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash 2>/dev/null || true
    fi

    # Install delta (git diff)
    if ! command -v delta &>/dev/null; then
        log_info "Installing delta..."
        DELTA_VERSION="0.16.5"
        curl -sLO "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb" 2>/dev/null || true
        sudo dpkg -i "git-delta_${DELTA_VERSION}_amd64.deb" 2>/dev/null || true
        rm -f "git-delta_${DELTA_VERSION}_amd64.deb"
    fi

    log_success "Modern CLI tools installed"
}

# -----------------------------------------------------------------------------
# Set zsh as default shell
# -----------------------------------------------------------------------------
set_default_shell() {
    if [[ "$SHELL" != *"zsh"* ]]; then
        log_info "Setting zsh as default shell..."
        sudo chsh -s "$(which zsh)" "$(whoami)" 2>/dev/null || true
    fi
}

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------
main() {
    install_apt_packages
    install_modern_tools
    set_default_shell
    log_success "Linux setup complete!"
}

main "$@"
