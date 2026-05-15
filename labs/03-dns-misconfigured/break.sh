#!/bin/bash
echo "[*] Backing up DNS config..."
sudo cp /etc/resolv.conf /etc/resolv.conf.bak
echo "[*] Injecting bad DNS server..."
echo "nameserver 1.2.3.4" | sudo tee /etc/resolv.conf
echo "[*] Done. DNS is now broken."
