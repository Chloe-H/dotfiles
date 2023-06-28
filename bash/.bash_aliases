# == git ==
alias git_unpushed="git log --branches --not --remotes --no-walk --decorate --oneline"


# == ls ==
alias lsc="ls --group-directories-first -1A"


# == tmux ==

# Check whether a tmux session with the given name exists; if it doesn't, create
# it.
# Takes two positional arguments: the starting directory and the session name.
function create_tmux_session() {
    start_directory=$1
    session_name=$2

    tmux has-session -t ${session_name} &> /dev/null

    if [ $? != 0 ]; then
        tmux new-session \
            -c ${start_directory} \
            -s ${session_name} \
            -d
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
    # Set default values
    starting_session_name="scratch"
    default_working_dir=~

    # If the first positional argument is a directory...
    if [[ -d ${1} ]]; then
        default_working_dir="${1}"

        # Shift positional parameters left 1, effectively removing the first
        # positional argument from $@
        shift 1
    fi

    # All positional arguments, starting at index 1, as separate strings
    session_names=$@

    # If there's only one element in the array and its length is zero, then
    # no session names were provided
    if [[ ${#session_names[@]} -eq 1 && ${#session_names} -eq 0 ]]; then
        create_tmux_session "${default_working_dir}" "${starting_session_name}"
    else
        # Trying to grab the 0th element of session_names doesn't behave like I
        # would expect, so I'm doing this
        starting_session_name="${1}"

        for session_name in ${session_names[@]}; do
            create_tmux_session "${default_working_dir}" "${session_name}"
        done
    fi

    tmux attach-session \
        -c ${default_working_dir} \
        -t ${starting_session_name}
}

# Easily start one or more tmux sessions
alias tmuxc="start_tmux"
