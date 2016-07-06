#!/bin/bash
mkdir /app/backups;
tar czvf /app/backups/uploads.zip /app/public/*;
mysqldump -u$VDT_DB_USER -p$VDT_DB_PASS -h$VDT_DB_HOST $VDT_DB_NAME > /app/backups/site_dump.sql;
wget http://scripts.hgsso.com/viaduct_to_s3.sh;
chmod u+x viaduct_to_s3.sh;
bash viaduct_to_s3.sh;
rm -rf /app/viaduct_to_s3.sh;
rm -rf /app/backups;
