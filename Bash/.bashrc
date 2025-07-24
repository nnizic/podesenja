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
set_path /opt/flutter/3.29.2/bin
set_path /opt/sbin
set_path /home/giz73/.cabal/bin

# aliases

alias ll='ls -latr'
alias invim='nvim $(fzf -m --preview="bat --color=always {}")'

eval "$(starship init bash)"
