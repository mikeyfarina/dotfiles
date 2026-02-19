# =============================================================================
# Tool Integrations
# =============================================================================

# -----------------------------------------------------------------------------
# zoxide (smart cd)
# -----------------------------------------------------------------------------
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
fi

# -----------------------------------------------------------------------------
# fzf (fuzzy finder)
# -----------------------------------------------------------------------------
if command -v fzf &>/dev/null; then
    # Source fzf configuration based on platform
    if [[ -f ~/.fzf.zsh ]]; then
        source ~/.fzf.zsh
    elif [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
        # Linux package manager install
        source /usr/share/fzf/key-bindings.zsh
        source /usr/share/fzf/completion.zsh
    fi

    # fzf options
    export FZF_DEFAULT_OPTS="
        --height 40%
        --layout=reverse
        --border
        --inline-info
    "

    # Use fd if available (faster than find)
    if command -v fd &>/dev/null; then
        export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
    fi
fi

# -----------------------------------------------------------------------------
# mise (polyglot runtime manager)
# -----------------------------------------------------------------------------
if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
fi

# -----------------------------------------------------------------------------
# bun completions
# -----------------------------------------------------------------------------
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"
