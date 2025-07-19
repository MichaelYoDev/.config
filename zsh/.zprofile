eval "$(/opt/homebrew/bin/brew shellenv)"

# Setting PATH for Python 3.12
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:${PATH}"
export PATH

# ---- Go stuff ----
export GOPATH="/Users/michaeloliveira/go"
export GOBIN="$HOME/go/bin"
case ":$PATH:" in
    ":$GOBIN:") ;;
    *) export PATH="$GOBIN:$PATH" ;;
esac

path+=('/Users/michaeloliveira/.local/bin')

# ---- dbus for zathura ----
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"
. "/Users/michaeloliveira/.deno/env"

