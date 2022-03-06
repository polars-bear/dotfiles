# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

# Set editor
export EDITOR='nvim'

# Set PATH
export GOROOT=/usr/local/go
export GOHOME=$HOME/go
export LSPSERVERS=$HOME/.local/share/nvim/lsp_servers

export PATH=$PATH:$GOROOT/bin:$GOHOME/bin
