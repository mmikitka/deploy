if shopt -q login_shell; then
  [[ -r /etc/profile ]] && source /etc/profile
  [[ -t 0 && $(tty) == /dev/tty1 && ! $DISPLAY ]] && exec startx -- vt1
else
  exit 1
fi
