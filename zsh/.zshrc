# --- Plugins ---
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# --- Prompt + Git Info ---
autoload -Uz colors && colors

git_sign() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local branch symbols=""
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null)

    # Staged changes
    if ! git diff --cached --quiet 2>/dev/null; then
      symbols+="%{$fg[green]%}+"
    fi

    # Unstaged changes
    if ! git diff --quiet 2>/dev/null; then
      symbols+="%{$fg[yellow]%}✗"
    fi

    # Untracked files
    if [[ -n $(git ls-files --others --exclude-standard 2>/dev/null) ]]; then
      symbols+="%{$fg[red]%}!"
    fi

    # Merge conflicts
    if [[ -n $(git ls-files -u 2>/dev/null) ]]; then
      symbols+="%{$fg[magenta]%}?"
    fi

    echo "git:(%{$fg[red]%}${branch}%{$fg[blue]%})${symbols}%{$reset_color%}"
  fi
}

PROMPT="%{$fg[cyan]%}%2~ %{$fg_bold[blue]%}$(git_prompt_info) %{$reset_color%}» "

# --- Startup ---
fastfetch

# --- History ---
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# --- Aliases ---
alias vi="nvim"

# --- Tmux Scripts ---
export PATH=$PATH:/Users/michaeloliveira/.config/scripts/term
bindkey -s ^f "tmux-sessionizer.sh\n"
bindkey -s ^o "open-files.sh\n"

# --- Go Environment ---
export GOPATH="/Users/michaeloliveira/go"
export GOBIN="$HOME/go/bin"
case ":$PATH:" in
    ":$GOBIN:") ;;
    *) export PATH="$GOBIN:$PATH" ;;
esac

path+=('/Users/michaeloliveira/.local/bin')

# --- External Envs ---
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"
. "/Users/michaeloliveira/.deno/env"
