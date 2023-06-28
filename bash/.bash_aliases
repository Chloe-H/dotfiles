# == git ==
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
# If the first argument is a valid directory name, use it as the default working
# directory rather than a session name.
# If no arguments are given, create a session with a default name and working
# directory.
# Attach to the first session created.
function start_tmux() {
    # Get the value of the positional argument at index 1;
    # default to "scratch" if that argument is not set or empty
    starting_session_name="${1:-"scratch"}"

    default_working_dir="~"

    # All positional arguments, starting at index 1, as separate strings
    session_names=$@

    # If the first positional argument is the name of an existing directory,
    # use it as the default working directory for tmux
    if [[ -d ${session_names[0]} ]]; then
        default_working_dir="${session_names[0]}"
        unset session_names[0] # Remove the first element
        # session_names=("${session_names[@]:1}") # Remove the first element
    fi

    # If there's only one element in the array and its length is zero, then
    # no session names were provided
    if [[ ${#session_names[@]} -eq 1 && ${#session_names} -eq 0 ]]; then
        create_tmux_session "${starting_session_name}"
    else
        for session_name in ${session_names[@]}; do
            create_tmux_session ${session_name}
        done
    fi

    tmux attach -t ${starting_session_name} -c ${default_working_dir}
}

# Easily start one or more tmux sessions
alias tmuxc="start_tmux"
