#!/bin/bash
echo "[*] Changing Nginx to listen on port 8080 instead of 80..."
sudo sed -i 's/listen 80/listen 8080/g' /etc/nginx/sites-available/default
sudo sed -i 's/listen \[::\]:80/listen [::]:8080/g' /etc/nginx/sites-available/default
sudo systemctl restart nginx
echo "[*] Done. Port 80 is now unreachable."
