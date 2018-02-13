BREW_EXEC='/usr/local/bin/brew'
OPERATION="cntlm"

STATUS=`$BREW_EXEC services list | grep $OPERATION`

if [[ $STATUS = *"stopped"* ]]; then
    echo "Starting Proxy"
    echo `$BREW_EXEC services start $OPERATION`
else
    echo `$BREW_EXEC services stop $OPERATION`
fi

source "/Users/mark/.config/scripts/proxy/setup_variables.sh"
