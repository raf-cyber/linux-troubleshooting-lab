#!/bin/bash

echo "[*] Restoring Nginx to listen on port 80..."
sudo sed -i 's/listen 8080 default_server/listen 80 default_server/g' /etc/nginx/sites-available/default
sudo sed -i 's/listen \[::\]:8080 default_server/listen [::]:80 default_server/g' /etc/nginx/sites-available/default
sudo systemctl restart nginx
echo "[*] Fix applied. Nginx is back on port 80."

