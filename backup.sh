#!/bin/bash
DATE=$(date +%Y-%m-%d)
BACKUP_DIR="/home/javed/backups"
mkdir -p $BACKUP_DIR

echo "================================"
echo "   BACKUP STARTED: $DATE"
echo "================================"

# Backup website files
tar -czf $BACKUP_DIR/website-$DATE.tar.gz /var/www/

# Backup nginx configuration
tar -czf $BACKUP_DIR/nginx-$DATE.tar.gz /etc/nginx/

# Backup MySQL databases
sudo mysqldump -u root --all-databases > $BACKUP_DIR/database-$DATE.sql

# Delete backups older than 7 days
find $BACKUP_DIR -name "*.tar.gz" -mtime +7 -delete
find $BACKUP_DIR -name "*.sql" -mtime +7 -delete

echo "================================"
echo "   BACKUP COMPLETED: $DATE"
echo "================================"
ls -lh $BACKUP_DIR
