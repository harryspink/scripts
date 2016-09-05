# Script Repository

Script repository is a storage of useful scripts - currently contains:

  - Wordpress backups for viaduct.io
  - laravel backup for viaduct.io
  - generic folder to s3 backup

### Usage
#### Wordpress / Laravel backup to S3
- viaduct_laravel_backup.sh
- viaduct_wp_backup.sh
 
There are no external dependancies that are not already provided by the viaduct.io container templates.

#### Environment variables
Add the following environment variables to the viaduct.io project
- BACKUP_DIR
  - /app/backups
- S3_BUCKET
  - *Amazon S3 Bucket Name*
- S3 Key
    - *Amazon S3 Key with permission to access the bucket*
- S3 Secret
    - *Amazon S3 Secret with permission to access the bucket*

The main database credentials are used to generate a database dump
- VDT_DB_HOST
- VDT_DB_NAME
- VDT_DB_USER
- VDT_DB_PASS

The backup will be stored in a sub folder of the bucket named after the app
- VDT_APP

Each backup is then stored in a sub folder of the app name using the date string
```
Y.m.d-h.m.s
```

#### Testing
```
$ vdt console --app=app_name
$ wget -O - http://scripts.hgsso.com/viaduct_wp_backup.sh | sh
```

### Scheduling backups
See screenshot below

![Screenshot of scheduled task](http://hgs.so/screenshots/viaduct-scheduled-backup.png)
