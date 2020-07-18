PATH="$PATH:/home/mmikitka/.local/bin"

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

complete -C /home/matt/bin/mc mc
