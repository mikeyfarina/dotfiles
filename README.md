# Dotfiles

Personal dotfiles managed for cross-platform use (macOS + GitHub Codespaces).

## Quick Start

### Fresh Machine

```bash
git clone https://github.com/mikeyfarina/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
exec zsh
```

### GitHub Codespaces

1. Go to [GitHub Settings > Codespaces](https://github.com/settings/codespaces)
2. Under "Dotfiles", select this repository
3. New codespaces will automatically run `install.sh`

## Structure

```
dotfiles/
├── install.sh              # Main entry point
├── shell/
│   ├── zshrc               # Main zsh config (sources everything)
│   ├── aliases.zsh         # Command aliases
│   ├── exports.zsh         # Environment variables
│   ├── functions.zsh       # Custom shell functions
│   ├── nvm.zsh             # NVM lazy loading
│   ├── options.zsh         # Zsh options/settings
│   ├── path.zsh            # PATH configuration
│   └── tools.zsh           # Tool integrations (fzf, zoxide, etc.)
├── git/
│   ├── gitconfig           # Git configuration
│   └── gitignore_global    # Global gitignore
├── tools/
│   └── p10k.zsh            # Powerlevel10k config
└── scripts/
    ├── setup-linux.sh      # Linux/Codespaces setup
    └── setup-macos.sh      # macOS setup
```

## Local Overrides

Create `~/.zshrc.local` for machine-specific settings that shouldn't be tracked:

```zsh
# Example: Work-specific configs
export WORK_API_KEY="..."
alias deploy="./scripts/deploy-work.sh"
```

## What's Included

### Shell
- [Oh My Zsh](https://ohmyz.sh/) with plugins
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) prompt (Pure style)
- Lazy-loaded NVM for fast startup
- Smart history settings

### CLI Tools
| Tool | Replaces | Description |
|------|----------|-------------|
| [eza](https://github.com/eza-community/eza) | `ls` | Modern ls with icons & git |
| [bat](https://github.com/sharkdp/bat) | `cat` | Syntax highlighting |
| [fd](https://github.com/sharkdp/fd) | `find` | Faster find |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | `grep` | Faster grep |
| [fzf](https://github.com/junegunn/fzf) | - | Fuzzy finder |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | `cd` | Smarter cd |
| [delta](https://github.com/dandavison/delta) | `diff` | Better git diffs |

### Key Bindings
| Binding | Action |
|---------|--------|
| `Ctrl+R` | Fuzzy search history |
| `Ctrl+T` | Fuzzy find files |
| `Alt+C` | Fuzzy cd into directory |
| `z <partial>` | Smart cd (zoxide) |

## Updating

```bash
cd ~/dotfiles
git pull
./install.sh
exec zsh
```
