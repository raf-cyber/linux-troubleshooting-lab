#!bin/bash

echo "[*] Breaking Nginx config..."
sudo cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
sudo bash -c 'echo "random garbage text" >> /etc/nginx/nginx.conf'
sudo systemctl restart nginx
echo "[*} Done. Ngnix should now be broken."
