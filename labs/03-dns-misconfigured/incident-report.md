# Incident Report — Scenario 03: DNS Misconfigured

## Summary
Server could not resolve any domain names. All DNS lookups timed out,
making the server unable to reach external services by hostname.

## Timeline
| Time | Action |
|------|--------|
| T+00 | Alert: nslookup google.com returns "no servers could be reached" |
| T+05 | Checked /etc/resolv.conf — found nameserver set to 1.2.3.4 |
| T+10 | Confirmed 1.2.3.4 is a non-existent DNS server |
| T+15 | Replaced bad nameserver with 8.8.8.8 (Google DNS) |
| T+20 | Verified DNS resolution working via nslookup google.com |

## Root Cause
The nameserver entry in /etc/resolv.conf was changed to an invalid IP
address (1.2.3.4) that does not host a DNS service. All DNS queries
timed out as a result.

## Commands Used
```bash
nslookup google.com
cat /etc/resolv.conf
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
```

## Resolution
Replaced the invalid nameserver with Google's public DNS server (8.8.8.8)
in /etc/resolv.conf. DNS resolution was restored immediately.

## Lessons Learned
- /etc/resolv.conf controls which DNS server Linux uses
- nslookup is the fastest way to test DNS resolution
- 8.8.8.8 (Google) and 1.1.1.1 (Cloudflare) are reliable public DNS
  servers useful for recovery
- On WSL2, /etc/resolv.conf may be a symlink managed by the system —
  always check before editing
