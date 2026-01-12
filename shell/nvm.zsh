# =============================================================================
# NVM - Lazy Loading (faster shell startup)
# =============================================================================

export NVM_DIR="$HOME/.nvm"

# Only set up lazy loading if NVM is installed
if [[ -d "$NVM_DIR" ]]; then
    # Lazy load NVM - only loads when you first use nvm/node/npm/npx
    nvm() {
        unset -f nvm node npm npx
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        nvm "$@"
    }

    node() {
        unset -f nvm node npm npx
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        node "$@"
    }

    npm() {
        unset -f nvm node npm npx
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        npm "$@"
    }

    npx() {
        unset -f nvm node npm npx
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        npx "$@"
    }
fi
