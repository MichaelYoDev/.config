# Plugins ======================================================================
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Prompt =======================================================================
autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst
add-zsh-hook precmd vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats '%F{blue}git:(%F{red}%b%u%c%F{blue})%f'
zstyle ':vcs_info:git*' unstagedstr '%F{yellow}*%f'
zstyle ':vcs_info:git*' stagedstr '%F{green}+%f'
zstyle ':vcs_info:*:*' check-for-changes true

PROMPT='%F{green}%B%2~%b%f${vcs_info_msg_0_:+ ${vcs_info_msg_0_}} $ '

# Startup ======================================================================
nerdfetch
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach-session -t home || tmux new-session -s home
fi

# History ======================================================================
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history hist_expire_dups_first hist_ignore_dups hist_verify

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Aliases ======================================================================
alias vi="nvim"
alias ls="ls -ACGp" # all files, columns, colors, "/" after directory
alias micro='f() {
  file="micro/$(date +%Y-%m-%d-%H%M).md"
  hugo new "$file" >/dev/null
  $EDITOR -c "normal! Gzzo" "content/$file"
}; f' # type micro to make and open new microblog post
alias deploy="~/.config/scripts/term/deploy.sh"

# Tmux =========================================================================
export PATH=$PATH:/Users/michaeloliveira/.config/scripts/term
bindkey -s ^f "tmux-sessionizer.sh\n"

# Exports ======================================================================
export EDITOR="nvim"
export MANPAGER="nvim +Man!"
