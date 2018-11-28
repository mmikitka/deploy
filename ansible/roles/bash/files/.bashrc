PATH="$PATH:/home/mmikitka/.local/bin"

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

HISTSIZE=10000
HISTFILESIZE=50000

OPUS_DATA_DIR="~/.local/share/opus"

if [ -r ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi
