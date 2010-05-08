#! /bin/sh

# Add this in your .$(SHELL)rc, you have choice between an alias or a function
#
# alias myagent="~/script/myagent \$@; source ~/.ssh/ssh-agent.$(hostname)"
#
# myagent() {
#   ~/script/ssh-agent.sh $@
#   source ~/.ssh/ssh-agent.$(hostname)
# }


agent=~/.ssh/ssh-agent.$(hostname)

life=$((6 * 3600))

if test $# -gt 0; then
    if test "$1" = '-t'; then
        if (echo "$2" | grep -Exq '[[:digit:]]+'); then
            life=$(( $2 * 3600 ))
        else
            echo "$2 is not a digit." >&2
        fi
    else
        echo "$1 not recognize" >&2
    fi
fi

newAgent ()
{
    echo "new agent on $(hostname) of $((life / 3600)) hours"
    ssh-agent -t $life > $agent
    source $agent > /dev/null
}

if test -e $agent; then
    source $agent >/dev/null
    # Check if an agent is already running.
    ssh-add -l >/dev/null 2>/dev/null
    if test $? -eq 2; then
        newAgent
    else
        echo "old agent on $(hostname)"
    fi
else
    newAgent
fi

# Add private key.
if ! (ssh-add -l 2>/dev/null | grep -q id_rsa); then
    ssh-add ~/.ssh/id_rsa
fi
