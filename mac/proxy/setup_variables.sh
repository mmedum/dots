BREW_EXEC='/usr/local/bin/brew'
OPERATION="cntlm"

STATUS=`$BREW_EXEC services list | grep $OPERATION`

if [[ $STATUS = *"stopped"* ]]; then
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset ALL_PROXY
    unset http_proxy
    unset https_proxy
    unset all_proxy
    unset NO_PROXY
    unset no_proxy
else 
    echo "cntlm started, setting up variables"
    export HTTP_PROXY='http://localhost:3128'
    export HTTPS_PROXY=$HTTP_PROXY
    export ALL_PROXY=$HTTP_PROXY
    export http_proxy=$HTTP_PROXY
    export https_proxy=$HTTP_PROXY
    export all_proxy=$HTTP_PROXY
    export NO_PROXY=.danskenet.net,teamfoundation
    export no_proxy=$NO_PROXY
fi
