# Pour que les variables d'environnement de l'agent ssh soit chargee,
# il faut ajouter un alias dans la conf de votre shell preferer.
#
# alias myagent="/path/to/ssh-agent.sh; source ~/.ssh/ssh-agent.$(hostname)"


agent=~/.ssh/ssh-agent.$(hostname)

newAgent ()
{
    echo new agent
    ssh-agent -t 21600 > $agent
    source $agent > /dev/null
}

if test -e $agent; then
    source $agent >/dev/null
    # Check if an agent is already running.
    ssh-add -l >/dev/null 2>/dev/null
    if test $? -eq 2; then
        newAgent
    else
        echo old agnet
    fi
else
    newAgent
fi

# Add private key.
if ! (ssh-add -l 2>/dev/null | grep -q id_rsa); then
    ssh-add ~/.ssh/id_rsa
fi
