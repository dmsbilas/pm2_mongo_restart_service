sudo apt-get install jq

service_name=$(jq -r '.name' config.json)

systemctl stop $service_name
systemctl disable $service_name
rm /etc/systemd/system/$service_name
rm /etc/systemd/system/$service_name # and symlinks that might be related
rm /usr/lib/systemd/system/$service_name 
rm /usr/lib/systemd/system/$service_name # and symlinks that might be related
systemctl daemon-reload
systemctl reset-failed

echo "Service $service_name removed"
