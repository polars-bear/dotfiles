#!/bin/zsh
# ================================================= #
# d8888b.  .d88b.  db       .d8b.  d8888b. .d8888.  #
# 88  `8D .8P  Y8. 88      d8' `8b 88  `8D 88'  YP  #
# 88oodD' 88    88 88      88ooo88 88oobY' `8bo.    #
# 8888P   88    88 88      8888888 88`8b     `Y8b.  #
# 88      `8b  d8' 88booo. 88   88 88 `88. db   8D  #
# 88       `Y88P'  Y88888P YP   YP 88   YD `8888Y'  #
# ================================================= #


# ================================================= #
# PLUGINS & OPTIONS 
# ================================================= #

export ZDOTDIR=$HOME/.config/zsh

# source custom functions
source "$ZDOTDIR/zsh-functions"

zsh_add_file "zsh-aliases"
zsh_add_file "zsh-vim-mode"

# plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

# set options
setopt menucomplete
setopt extendedglob
setopt interactive_comments

# use colors
autoload -U colors && colors

# configure history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$ZDOTDIR/.zsh_history"
setopt appendhistory
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS


# ================================================= #
# COMPLETIONS & KEYBINDS
# ================================================= #

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:lsof:*' menu yes select

zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.
compinit

# use Ctrl+k and Ctrl+j to scroll history
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^k" up-line-or-beginning-search # Up in history
bindkey "^j" down-line-or-beginning-search # Down in history

# Edit line in vim with Ctrl+e
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line


# ================================================= #
# GIT INFO
# ================================================= #

# show git repo and changes (zsh can be slow in repos)
# from https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

# add a function to check for untracked files in the directory.
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[staged]+='*' # signify new files with a bang
    fi
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%F{11}[%b]%F{9}%m%u%c%{$reset_color%}"


# ================================================= #
# PROMPT
# ================================================= #

# set PROMPT
setopt prompt_subst

# Prompt: user@pwd[git]*
PROMPT='%B%F{10}%n%F{5}@%F{4}%~%{$reset_color%}${vcs_info_msg_0_} %b'

# Prompt: user@pwd
# PROMPT='%B%F{10}%n%F{5}@%F{4}%~%{$reset_color%}%b '

# show execution time of last command
function preexec() {
  timer=${timer:-$SECONDS}
  ms_start=$(($(date +%s%0N)/1000000))
}

function precmd() {
  if [ $timer ]; then
    timer_diff=$(($SECONDS - $timer))
    ms_end=$(($(date +%s%0N)/1000000))
    ms_diff=$(($ms_end-$ms_start))

    if [ $timer_diff -gt 60 ]; then
        mins=$(($timer_diff/60))
        secs_rem=$(($timer_diff%60))
        export RPROMPT="%B%F{yellow}${mins}m ${secs_rem}s ${ms_rem}ms %{$reset_color%}%b"


    elif [ $timer_diff -gt 0 ]; then
        ms_rem=$(($ms_diff%1000))
        export RPROMPT="%B%F{yellow}${timer_diff}s ${ms_rem}ms %{$reset_color%}%b"
    else
        export RPROMPT="%B%F{yellow}${ms_diff}ms %{$reset_color%}%b"
    fi

    unset timer
  fi
}

# Add newline to prompt for command input
PROMPT+=$'\n%B%F{yellow}> %{$reset_color%}%b'


# ================================================= #
# PROGRAMS & PATH
# ================================================= #

# set default programs
export EDITOR="nvim"
export BROWSER="firefox"
export TERMINAL="konsole"
export SHELL="/usr/bin/zsh"

# extend PATH
export PATH=$PATH":$HOME/.local/bin"

