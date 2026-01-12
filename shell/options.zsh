# =============================================================================
# Zsh Options
# =============================================================================

# History
setopt SHARE_HISTORY          # Share history between sessions
setopt HIST_IGNORE_ALL_DUPS   # Don't record duplicates
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks
setopt HIST_VERIFY            # Show command before executing from history
setopt INC_APPEND_HISTORY     # Add commands immediately (not at shell exit)

# Directory navigation
setopt AUTO_CD                # cd by typing directory name
setopt AUTO_PUSHD             # Push directories onto stack
setopt PUSHD_IGNORE_DUPS      # Don't push duplicates
setopt PUSHD_SILENT           # Don't print stack after pushd/popd

# Completion
setopt COMPLETE_IN_WORD       # Complete from cursor position
setopt ALWAYS_TO_END          # Move cursor to end after completion

# Correction
setopt CORRECT                # Correct commands
# setopt CORRECT_ALL          # Correct all arguments (can be annoying)

# Globbing
setopt EXTENDED_GLOB          # Extended globbing syntax
setopt NO_CASE_GLOB           # Case insensitive globbing

# Jobs
setopt NO_BG_NICE             # Don't nice background jobs
setopt NO_HUP                 # Don't kill background jobs on exit
