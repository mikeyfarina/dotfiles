# =============================================================================
# Aliases
# =============================================================================

# -----------------------------------------------------------------------------
# Modern CLI replacements (require: eza, bat, fd, ripgrep)
# -----------------------------------------------------------------------------
if command -v eza &>/dev/null; then
    alias ls="eza --icons"
    alias ll="eza -la --icons --git"
    alias la="eza -a --icons"
    alias lt="eza -la --icons --git --sort=modified"
    alias tree="eza --tree --icons"
fi

if command -v bat &>/dev/null; then
    alias cat="bat --style=auto"
    alias catp="bat --style=plain"
fi

# -----------------------------------------------------------------------------
# Git shortcuts
# -----------------------------------------------------------------------------
alias g="git"
alias gs="git status"
alias gd="git diff"
alias gds="git diff --staged"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias glog="git log --oneline --graph --decorate -20"

# -----------------------------------------------------------------------------
# Navigation
# -----------------------------------------------------------------------------
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# -----------------------------------------------------------------------------
# Safety nets
# -----------------------------------------------------------------------------
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

# -----------------------------------------------------------------------------
# Misc
# -----------------------------------------------------------------------------
alias c="clear"
alias h="history"
alias reload="exec $SHELL -l"
alias path='echo $PATH | tr ":" "\n"'
