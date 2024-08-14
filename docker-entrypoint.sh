#!/bin/bash


run_app() {
  npx quartz build --serve
}


shutdown() {
  echo "Shutdown signal received"
  kill -TERM "$PID" 2>/dev/null
  wait "$PID"
  exit 0
}


trap 'shutdown' SIGTERM


if [ ! -f "/usr/src/app/docker-config/quartz.config.ts" ]; then
    cp /usr/src/app/quartz.config.ts /usr/src/app/docker-config/quartz.config.ts
else
    cp /usr/src/app/docker-config/quartz.config.ts /usr/src/app/quartz.config.ts
fi


if [ ! -f "/usr/src/app/docker-config/quartz.layout.ts" ]; then
    cp /usr/src/app/quartz.layout.ts /usr/src/app/docker-config/quartz.layout.ts
else
    cp /usr/src/app/docker-config/quartz.layout.ts /usr/src/app/quartz.layout.ts
fi


run_app &
PID=$!
echo "App is running with PID: $PID"

wait $PID