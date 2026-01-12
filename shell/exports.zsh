# =============================================================================
# Environment Variables
# =============================================================================

# XDG Base Directory (standardized config locations)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Editor
export EDITOR="vim"
export VISUAL="$EDITOR"

# History
export HISTSIZE=50000
export SAVEHIST=50000
export HISTFILE="$HOME/.zsh_history"

# Language
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
[[ -d "$PNPM_HOME" ]] && export PATH="$PNPM_HOME:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
[[ -d "$BUN_INSTALL" ]] && export PATH="$BUN_INSTALL/bin:$PATH"

# Local binaries
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
