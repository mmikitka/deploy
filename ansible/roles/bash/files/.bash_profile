export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
if shopt -q login_shell; then
  [[ -r /etc/profile ]] && source /etc/profile
  #[[ -t 0 && $(tty) == /dev/tty1 && ! $DISPLAY ]] \
  #  && exec /usr/bin/startx -- vt1
else
  exit 1
fi
