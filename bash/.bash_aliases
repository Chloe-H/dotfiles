# == git ==
alias gpo="git push origin"
alias git_unpushed="git log --branches --not --remotes --no-walk --decorate --oneline"


# == ls ==
alias lsc="ls --group-directories-first -1A"


# == tmux ==

# Check whether a tmux session with the given name exists; if it doesn't, create
# it.
function create_tmux_session() {
    session_name=$1

    tmux has-session -t ${session_name} &> /dev/null

    if [ $? != 0 ]; then
        tmux new-session -s ${session_name} -d
    fi
}

# Create one tmux session for each argument, and use the respective argument as
# the name.
# If no arguments are given, create a session with a default name.
# Attach to the first session created.
function start_tmux() {
    starting_session_name="${1:-"scratch"}"

    session_names=$@

    if [[ ${#session_names[@]} -eq 1 && ${#session_names} -eq 0 ]]; then
        create_tmux_session "${starting_session_name}"
    else
        for session_name in ${session_names[@]}; do
            create_tmux_session ${session_name}
        done
    fi

    tmux attach -t ${starting_session_name}
}

# Easily start one or more tmux sessions
alias tmuxc="start_tmux"
