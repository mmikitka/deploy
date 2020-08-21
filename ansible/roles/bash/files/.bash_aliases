alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias opus="vim -O ${OPUS_DATA_DIR}/inbox.opus ${OPUS_DATA_DIR}/backlog.opus ${OPUS_DATA_DIR}/doing.opus ${OPUS_DATA_DIR}/blocked.opus"
alias opusinbox="vim -O ${OPUS_DATA_DIR}/inbox.opus"
alias opusbacklog="vim -O ${OPUS_DATA_DIR}/backlog.opus"
alias opusdoing="vim -O ${OPUS_DATA_DIR}/doing.opus"
alias opusblocked="vim -O ${OPUS_DATA_DIR}/blocked.opus"
alias tasklog="vim ~/Documents/time-management/tasklog.csv"

if [ -r ~/.bash_aliases.local ]; then
  . ~/.bash_aliases.local
fi
