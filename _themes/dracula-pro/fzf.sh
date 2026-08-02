# shellcheck shell=bash

export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} \
  --color=bg+:{{Selection}} \
  --color=bg:{{Background}} \
  --color=border:{{Purple}} \
  --color=fg:{{Foreground}} \
  --color=gutter:{{Background}} \
  --color=header:{{Orange}} \
  --color=hl+:{{Cyan}} \
  --color=hl:{{Cyan}} \
  --color=info:{{Comment}} \
  --color=label:{{Comment}} \
  --color=marker:{{Pink}} \
  --color=pointer:{{Pink}} \
  --color=prompt:{{Purple}} \
  --color=query:{{Foreground}}:regular \
  --color=scrollbar:{{Purple}} \
  --color=separator:{{Orange}} \
  --color=spinner:{{Pink}} \
"
