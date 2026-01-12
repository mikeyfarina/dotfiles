# =============================================================================
# PATH Configuration
# =============================================================================

# Ensure unique entries in PATH
typeset -U path PATH

# Detect platform
case "$(uname -s)" in
    Darwin)
        # macOS paths
        path=(
            $HOME/bin
            $HOME/.local/bin
            /opt/homebrew/bin
            /opt/homebrew/sbin
            /usr/local/bin
            /usr/local/sbin
            /Library/TeX/texbin
            /Applications/Postgres.app/Contents/Versions/latest/bin
            /usr/bin
            /bin
            /usr/sbin
            /sbin
            $path
        )
        ;;
    Linux)
        # Linux/Codespaces paths
        path=(
            $HOME/bin
            $HOME/.local/bin
            /usr/local/bin
            /usr/local/sbin
            /usr/bin
            /bin
            /usr/sbin
            /sbin
            $path
        )

        # Linuxbrew if present
        if [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi
        ;;
esac
