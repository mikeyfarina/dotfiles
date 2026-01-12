#!/usr/bin/env bash
# =============================================================================
# Dotfiles Installation Script
# =============================================================================
# This script is automatically run by GitHub Codespaces when starting a new
# codespace. It can also be run manually on any machine.
#
# Usage: ./install.sh
# =============================================================================

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# -----------------------------------------------------------------------------
# Detect platform
# -----------------------------------------------------------------------------
detect_platform() {
    case "$(uname -s)" in
        Darwin) echo "macos" ;;
        Linux)
            if [[ -n "$CODESPACES" ]]; then
                echo "codespaces"
            else
                echo "linux"
            fi
            ;;
        *) echo "unknown" ;;
    esac
}

PLATFORM=$(detect_platform)
log_info "Detected platform: $PLATFORM"

# -----------------------------------------------------------------------------
# Backup existing file if it exists
# -----------------------------------------------------------------------------
backup_file() {
    local file="$1"
    if [[ -e "$file" && ! -L "$file" ]]; then
        mkdir -p "$BACKUP_DIR"
        mv "$file" "$BACKUP_DIR/"
        log_warn "Backed up existing $file to $BACKUP_DIR/"
    elif [[ -L "$file" ]]; then
        rm "$file"
        log_info "Removed existing symlink $file"
    fi
}

# -----------------------------------------------------------------------------
# Create symlink
# -----------------------------------------------------------------------------
create_symlink() {
    local src="$1"
    local dest="$2"

    if [[ ! -e "$src" ]]; then
        log_error "Source file does not exist: $src"
        return 1
    fi

    backup_file "$dest"
    ln -sf "$src" "$dest"
    log_success "Linked $dest -> $src"
}

# -----------------------------------------------------------------------------
# Install Oh My Zsh
# -----------------------------------------------------------------------------
install_oh_my_zsh() {
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        log_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        log_success "Oh My Zsh installed"
    else
        log_info "Oh My Zsh already installed"
    fi
}

# -----------------------------------------------------------------------------
# Install Zsh plugins
# -----------------------------------------------------------------------------
install_zsh_plugins() {
    local ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

    # Powerlevel10k
    if [[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]]; then
        log_info "Installing Powerlevel10k..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
        log_success "Powerlevel10k installed"
    fi

    # zsh-autosuggestions
    if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
        log_info "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
        log_success "zsh-autosuggestions installed"
    fi

    # zsh-syntax-highlighting
    if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
        log_info "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
        log_success "zsh-syntax-highlighting installed"
    fi

    # zsh-completions
    if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]]; then
        log_info "Installing zsh-completions..."
        git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"
        log_success "zsh-completions installed"
    fi

    # zsh-history-substring-search
    if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-history-substring-search" ]]; then
        log_info "Installing zsh-history-substring-search..."
        git clone https://github.com/zsh-users/zsh-history-substring-search "$ZSH_CUSTOM/plugins/zsh-history-substring-search"
        log_success "zsh-history-substring-search installed"
    fi
}

# -----------------------------------------------------------------------------
# Create symlinks for dotfiles
# -----------------------------------------------------------------------------
create_symlinks() {
    log_info "Creating symlinks..."

    # Shell
    create_symlink "$DOTFILES_DIR/shell/zshrc" "$HOME/.zshrc"

    # Git
    create_symlink "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
    create_symlink "$DOTFILES_DIR/git/gitignore_global" "$HOME/.gitignore_global"

    # P10k (link to home as fallback)
    create_symlink "$DOTFILES_DIR/tools/p10k.zsh" "$HOME/.p10k.zsh"
}

# -----------------------------------------------------------------------------
# Run platform-specific setup
# -----------------------------------------------------------------------------
run_platform_setup() {
    case "$PLATFORM" in
        macos)
            if [[ -f "$DOTFILES_DIR/scripts/setup-macos.sh" ]]; then
                log_info "Running macOS setup..."
                bash "$DOTFILES_DIR/scripts/setup-macos.sh"
            fi
            ;;
        codespaces|linux)
            if [[ -f "$DOTFILES_DIR/scripts/setup-linux.sh" ]]; then
                log_info "Running Linux/Codespaces setup..."
                bash "$DOTFILES_DIR/scripts/setup-linux.sh"
            fi
            ;;
    esac
}

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------
main() {
    echo ""
    echo "=========================================="
    echo "  Dotfiles Installation"
    echo "=========================================="
    echo ""

    install_oh_my_zsh
    install_zsh_plugins
    create_symlinks
    run_platform_setup

    echo ""
    log_success "Dotfiles installation complete!"
    echo ""

    if [[ "$PLATFORM" != "codespaces" ]]; then
        log_info "Run 'exec zsh' to reload your shell"
    fi
}

main "$@"
