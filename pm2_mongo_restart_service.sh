#!/bin/bash

# Load NVM and Node.js
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"
nvm use 22.14.0

# Define full path to PM2
PM2_BIN="$(which pm2)"

# Check PM2 process status
pm2_status=$($PM2_BIN status "stat_viewer" | grep "stat_viewer" | awk '{print $18}' | tr -d '[:space:]')

if [[ "$pm2_status" == "stopped" ]]; then
    echo "PM2 Restarting"
    $PM2_BIN stop all
    $PM2_BIN start /var/www/html/stat-viewer/app.js --name stat_viewer
    echo "PM2 restarted by pm2_mongo_restart_service."
else 
    echo "PM2 running"
fi

# Check if MongoDB is running
if pgrep -x "mongod" > /dev/null; then
    echo "MongoDB service is running."
else
    sudo systemctl restart mongod
    echo "MongoDB restarted by pm2_mongo_restart_service."
fi