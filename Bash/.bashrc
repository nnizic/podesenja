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

# custom installed packes are in /opt/sbin
set_path /opt/sbin

# to install Haskell packages using cabal
set_path /home/giz73/.cabal/bin

# add git branch to prompt - not needed with powerline-go
#. ~/.git-prompt.sh
#export GIT_PSI_SHOWDIRTYSTATE=1
#export PS1='\[\033[0m\][\[\033[1;34m\]\u:\[\033[36m\]\W\[\033[1;35m\]$(__git_ps1 " (%s)")\[\033[0m\]]$(powerline-go -error $? -jobs $(jobs -p | wc -l))'

# change colors of listed folders and files
export LS_OPTIONS='--color=auto'
eval "$(dircolors -b)"
alias ls='ls $LS_OPTIONS'

# Powerline-go support
function _update_ps1() {
    PS1="$(powerline-go -error $? -hostname-only-if-ssh -cwd-max-depth 3 -mode compatible -colorize-hostname -shell bash)"
}

if [ "$TERM" != "linux" ] && command -v powerline-go &>/dev/null; then
    PROMPT_COMMAND="_update_ps1"
fi
