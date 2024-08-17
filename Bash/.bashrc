set_path(){

    # Check if user id is 1000 or higher
    [ "$(id -u)" -ge 1000 ] || return

    for i in "$@";
    do

    # Check if the directory exists
    [ -d "$i" ] || continue

    # Check if it is not already on your $PATH.
    echo "$PATH" | grep -Eq "(^|:)$i(:|$)" && continue

    # Then append it to $PATH and export it
    export PATH="${PATH}:$i"
    done
}

set_path /opt/sbin

# add git branch to prompt
. ~/.git-prompt.sh
export GIT_PSI_SHOWDIRTYSTATE=1
export PS1='\[\033[0m\][\[\033[1;34m\]\u@\h \[\033[36m\]\W\[\033[1;35m\]$(__git_ps1 " (%s)")\[\033[0m\]]$ '

# change colors of listed folders and files
export LS_OPTIONS='--color=auto'
eval "$(dircolors -b)"
alias ls='ls $LS_OPTIONS'

# command line file completion
# git clone https://github.com/pindexis/qfc $HOME/.qfc
[[ -s "$HOME/.qfc/bin/qfc.sh" ]] && source "$HOME/.qfc/bin/qfc.sh"
