PROMPT='${return_status} ${prompt_suffix}'

local return_status="%2F{036}%n%f 🦊 %F{030}%~%f"

local prompt_suffix="%F{111}❯%f "

#Original
#PROMPT='${return_status} %{$fg[blue]%}$(get_pwd)%{$reset_color%}${prompt_suffix}'

#local return_status="%(?:%{$fg_bold[green]%}🦊:%{$fg_bold[red]%}🤡)"

#local prompt_suffix="%{$fg[cyan]%} ❯%{$reset_color%} "

#functions

function get_pwd(){
  git_root=$PWD
  while [[ $git_root != / && ! -e $git_root/.git ]]; do
     git_root=$git_root:h
  done
  if [[ $git_root = / ]]; then
    unset git_root
    prompt_short_dir=%~
  else
    parent=${git_root%\/*}
    prompt_short_dir=${PWD#$parent/}
  fi
  echo $prompt_short_dir
}

#ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[green]%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
#ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}✗"
#ZSH_THEME_GIT_PROMPT_CLEAN=""

# LS_COLORS ==================================================================

alias ls='ls --color=auto'

LSCOLORS=gxafexDxfxegedabagacad
export LSCOLORS
LS_COLORS=$LS_COLORS:"di=36":"ln=30;45":"so=34:pi=1;33":"ex=35":"bd=34;46":"cd=34;43":"su=30;41":"sg=30;46":"ow=30;43":"tw=30;42":"*.js=01;33":"*.json=33":"*.jsx=38;5;117":"*.ts=38;5;75":"*.css=38;5;27":"*.scss=38;5;169"
export LS_COLORS

#SELECTION COLOUR

# Completer ====================================================================

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
DESCRIPTIONS='%B%F{85} › %f%%F{green}%d%b%f'
WARNINGS='%F{yellow} › %fno matches for %F{green}%d%f'
ERROR='%B%F{red} › %f%e %d error'

zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} "ma=38;5;253;48;5;23"
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format $DESCRIPTIONS
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format $WARNINGS
zstyle ':completion:*:corrections' format $ERROR
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' '*?.old' '*?.pro'

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

