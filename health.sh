#!/bin/bash
echo "================================"
echo "   SERVER HEALTH REPORT"
echo "   $(date)"
echo "================================"

echo "--- DISK SPACE ---"
df -h /

echo "--- MEMORY USAGE ---"
free -h

echo "--- TOP 5 CPU PROCESSES ---"
ps aux --sort=-%cpu | head -6

echo "--- SERVICES STATUS ---"
echo "nginx:      $(systemctl is-active nginx)"
echo "mysql:      $(systemctl is-active mysql)"
echo "ssh:        $(systemctl is-active ssh)"
echo "fail2ban:   $(systemctl is-active fail2ban)"
echo "php8.3-fpm: $(systemctl is-active php8.3-fpm)"

echo "--- FAILED LOGINS TODAY ---"
sudo grep "Failed password" /var/log/auth.log | wc -l

echo "================================"
echo "Health Check Complete!"
echo "================================"
