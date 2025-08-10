# --- Plugins ---
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# --- Prompt ---
autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst
add-zsh-hook precmd vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats '%F{blue}git:(%F{red}%b%u%c%F{blue})%f'
zstyle ':vcs_info:git*' unstagedstr '%F{yellow}*%f'
zstyle ':vcs_info:git*' stagedstr '%F{green}+%f'
zstyle ':vcs_info:*:*' check-for-changes true

PROMPT='%F{cyan}%B%2~%b%f${vcs_info_msg_0_:+ ${vcs_info_msg_0_}} $ '

# --- Startup ---
nerdfetch

# --- History ---
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history hist_expire_dups_first hist_ignore_dups hist_verify

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# --- Aliases ---
alias vi="nvim"
alias ls="eza -lh --group-directories-first --icons=auto"

# --- Tmux Scripts ---
export PATH=$PATH:/Users/michaeloliveira/.config/scripts/term
bindkey -s ^f "tmux-sessionizer.sh\n"
bindkey -s ^o "open-files.sh\n"

# --- Exports ---
export EDITOR="nvim"
export MANPAGER="nvim +Man!"
