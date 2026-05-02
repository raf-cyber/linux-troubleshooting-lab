# Scenario 01 — Nginx Won't Start

## Symptom
Nginx fails to start. Website is unreachable.

## Environment
- OS: Ubuntu (WSL2)
- Service: nginx
- Tools used: systemctl, journalctl, nginx -t

## Investigation

### Step 1 — Check service status
```bash
systemctl status nginx
```
**Finding:** Service in `failed` state. Exit code 1. 
ExecStartPre failed meaning config test failed before Nginx even started.

### Step 2 — Check logs
```bash
journalctl -u nginx -n 20
```
**Finding:** `[emerg] unexpected end of file, expecting "}"` at 13:08:39.
Log also shows Nginx was running fine before this — confirms a config change caused the break.

### Step 3 — Run config test directly
```bash
sudo nginx -t
```
**Finding:** Syntax error at line 85. Unexpected end of file.

## Root Cause
`/etc/nginx/nginx.conf` was corrupted. Garbage text was appended to the file 
breaking the bracket structure of the config. Nginx runs a config test before 
starting and fails immediately if syntax is invalid.

## Fix
```bash
sudo cp /etc/nginx/nginx.conf.bak /etc/nginx/nginx.conf
sudo nginx -t
sudo systemctl start nginx
```
Restored config from backup. Verified syntax clean. Restarted service successfully.

## Verification
```bash
systemctl status nginx
# Expected: active (running)
```

## Lesson
Always backup config files before editing (`cp file file.bak`).
Nginx's built-in config test (`nginx -t`) pinpoints the exact line of the error —
run this first before digging into logs.

## What if backup doesn't exist?
If the backup doesn't exist then try reinstalling Nginx which will restore the original config file.
Another option is manually editing the file since nginx -t told the exact line.
