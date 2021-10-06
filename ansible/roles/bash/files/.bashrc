PATH="$PATH:$HOME/.local/bin:$HOME/.node_modules/bin"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

HISTSIZE=10000
HISTFILESIZE=50000

OPUS_DATA_DIR="~/.local/share/opus"
BROWSER=/usr/bin/google-chrome

if [ -r ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -d ~/.bashrc.d ]; then
  for i in ~/.bashrc.d/*.bash; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi
