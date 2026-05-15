# Incident Report — Scenario 02: Port 80 Blocked

## Summary
Nginx was running but port 80 was unreachable. Requests to port 80 failed
while Nginx was actually listening on port 8080 due to a misconfigured
listen directive.

## Timeline
| Time | Action |
|------|--------|
| T+00 | Alert: curl http://localhost:80 returns "Failed to connect" |
| T+05 | Confirmed Nginx service is running via systemctl status nginx |
| T+10 | Tested port 8080 — Nginx responded normally |
| T+15 | Ran grep "listen" /etc/nginx/sites-available/default |
| T+20 | Found listen directive changed to 8080 for both IPv4 and IPv6 |
| T+25 | Restored correct port 80 config using sed |
| T+30 | Restarted Nginx, confirmed curl http://localhost:80 works |

## Root Cause
The listen directive in /etc/nginx/sites-available/default was changed
from port 80 to port 8080 for both IPv4 and IPv6 listeners, making the
service unreachable on the expected port.

## Commands Used
```bash
curl http://localhost:80
curl http://localhost:8080
systemctl status nginx
grep "listen" /etc/nginx/sites-available/default
sed -i 's/listen 8080 default_server/listen 80 default_server/g' /etc/nginx/sites-available/default
sed -i 's/listen [::]:8080 default_server/listen [::]:80 default_server/g' /etc/nginx/sites-available/default
systemctl restart nginx
```

## Resolution
Restored the correct listen directives in the Nginx site config and
restarted the service. Port 80 became reachable immediately after restart.

## Lessons Learned
- Nginx on Ubuntu splits config across multiple files. Always check
  /etc/nginx/sites-available/ not just nginx.conf
- Both IPv4 and IPv6 listeners must be configured correctly
- curl is the fastest first tool to test if a port is reachable
