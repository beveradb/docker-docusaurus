#!/bin/bash
msg() {
    echo -E "/* $1 */"
}

msg "Will run this Node service as $RUN_MODE mode..."

if [[ "$RUN_MODE" == "development" ]]; then
    yarn run start --port 80 --host 0.0.0.0 &
elif [[ "$RUN_MODE" == "production" ]]; then
   msg "Build current sources..."
   yarn serve --build --port 80 --host 0.0.0.0 &
elif [[ "$RUN_MODE" != "production" ]] && [[ "$RUN_MODE" != "development" ]]; then
   msg "The run mode env var was set to an unexpected value, running yarn script: $RUN_MODE"
   yarn run "$RUN_MODE" &
fi
[[ "$!" -gt 0 ]] && wait $!
