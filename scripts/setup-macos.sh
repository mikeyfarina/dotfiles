#!/usr/bin/env bash
# =============================================================================
# macOS Setup
# =============================================================================

set -e

log_info() { echo -e "\033[0;34m[INFO]\033[0m $1"; }
log_success() { echo -e "\033[0;32m[OK]\033[0m $1"; }

# -----------------------------------------------------------------------------
# Install Homebrew
# -----------------------------------------------------------------------------
install_homebrew() {
    if ! command -v brew &>/dev/null; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        log_success "Homebrew installed"
    else
        log_info "Homebrew already installed"
    fi
}

# -----------------------------------------------------------------------------
# Install packages via Homebrew
# -----------------------------------------------------------------------------
install_brew_packages() {
    log_info "Installing Homebrew packages..."

    local packages=(
        # Modern CLI tools
        eza
        bat
        fd
        ripgrep
        fzf
        zoxide
        git-delta
        tldr

        # Core utilities
        git
        gh
        jq
        tree
        htop
        btop
    )

    for pkg in "${packages[@]}"; do
        if ! brew list "$pkg" &>/dev/null; then
            brew install "$pkg"
        fi
    done

    # Setup fzf key bindings
    if [[ ! -f ~/.fzf.zsh ]]; then
        "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish
    fi

    log_success "Homebrew packages installed"
}

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------
main() {
    install_homebrew
    install_brew_packages
    log_success "macOS setup complete!"
}

main "$@"
