PROMPT='${return_status} %{$fg[blue]%}$(get_pwd)%{$reset_color%}${prompt_suffix}'

local return_status="%(?:%{$fg_bold[green]%}🦊:%{$fg_bold[red]%}🤡)"

local prompt_suffix="%{$fg[magenta]%} ❯%{$reset_color%} "

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

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# LS_COLORS ==================================================================
