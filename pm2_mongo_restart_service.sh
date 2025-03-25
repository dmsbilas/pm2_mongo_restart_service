#!/bin/bash

if pm2 status &> /dev/null; then
    echo "PM2 is running.";
else
    sudo pm2 stop all;
    sudo pm2 start /var/www/no_crop_comphy_api/dist/index.js --name comphy-admin-api;
    echo "PM2 restarted by pm2_mongo_restart_service.";

fi

# Check if MongoDB service (mongod) is running
if pgrep -x "mongod" > /dev/null;
then
    echo "MongoDB service is running.";
else
    sudo service mongod restart;
    echo "MongoDB restarted by pm2_mongo_restart_service.";
fi
