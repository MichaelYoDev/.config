# Homebrew environment (sets PATH and others)
eval "$(/opt/homebrew/bin/brew shellenv)"

# Python 3.12 PATH
PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:${PATH}"
export PATH

# Go environment
export GOPATH="/Users/michaeloliveira/go"
export GOBIN="$HOME/go/bin"
case ":$PATH:" in
    *":$GOBIN:"*) ;;  # already in PATH
    *) export PATH="$GOBIN:$PATH" ;;
esac

# Add local bin directory
path+=('/Users/michaeloliveira/.local/bin')

# dbus session address (for zathura)
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"

# Deno environment
source "/Users/michaeloliveira/.deno/env"
