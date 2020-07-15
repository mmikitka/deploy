#!/bin/bash

if [ -r /etc/bash_completion ]; then
  . /etc/bash_completion
fi

[[ $- = *i* ]] && source /usr/local/share/liquidprompt/liquidprompt
