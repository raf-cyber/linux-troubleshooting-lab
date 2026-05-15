#!/bin/bash
echo "[*] Restoring DNS config..."
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
echo "[*] Done. DNS restored."
