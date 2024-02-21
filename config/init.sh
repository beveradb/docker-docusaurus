#!/usr/bin/env bash

msg() {
    echo -E "/* $1 */"
}

DOCU_PATH="/docusaurus"

echo -e "Variables:
\\t- UID=${TARGET_UID}
\\t- GID=${TARGET_GID}
\\t- TEMPLATE=${TEMPLATE}
\\t- RUN_MODE=${RUN_MODE}"

if [[ ! -d "$DOCU_PATH"/node_modules ]]; then
    msg "Installing node modules..."
    cd "$DOCU_PATH"
    npm install &
    [[ "$!" -gt 0 ]] && wait $!
    cd ..
    chown -R "$TARGET_UID":"$TARGET_GID" "$DOCU_PATH"
else
    msg "Node modules already exist in $DOCU_PATH/node_modules"
fi

msg "Start supervisord to start Docusaurus..."
supervisord -c /etc/supervisor/conf.d/supervisord.conf

