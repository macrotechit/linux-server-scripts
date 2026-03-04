#!/bin/bash
echo "================================"
echo "   SERVER MONITOR REPORT"
echo "   $(date)"
echo "================================"

echo "--- SERVICES ---"
for service in nginx mysql ssh fail2ban php8.3-fpm; do
    status=$(systemctl is-active $service)
    if [ "$status" = "active" ]; then
        echo "$service: OK"
    else
        echo "$service: WARNING - NOT RUNNING!"
    fi
done

echo "--- DISK SPACE ---"
DISK=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
echo "Disk usage: $DISK%"
if [ $DISK -gt 80 ]; then
    echo "WARNING: Disk above 80%!"
else
    echo "Disk space OK"
fi

echo "--- MEMORY ---"
free -h | grep Mem

echo "--- FAILED LOGINS ---"
sudo grep "Failed password" /var/log/auth.log | wc -l

echo "================================"
echo "Monitor Complete!"
echo "================================"
