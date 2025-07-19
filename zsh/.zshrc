# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="michaelyodev"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# User configuration
fastfetch

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# ---- Aliases ----
alias vi="nvim"

# ---- Tmux Scripts ----
export PATH=$PATH:/Users/michaeloliveira/.config/scripts/term
bindkey -s ^f "tmux-sessionizer.sh\n"
bindkey -s ^o "open-files.sh\n"

# ---- Go stuff ----
export GOPATH="/Users/michaeloliveira/go"
export GOBIN="$HOME/go/bin"
case ":$PATH:" in
    ":$GOBIN:") ;;
    *) export PATH="$GOBIN:$PATH" ;;
esac

path+=('/Users/michaeloliveira/.local/bin')

export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"
. "/Users/michaeloliveira/.deno/env"
