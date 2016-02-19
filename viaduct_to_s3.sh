current_time=$(date "+%Y.%m.%d-%H.%M.%S")

putS3 ()
{
  path=$1
  file=$2
  aws_path=$3
  date=$(date +"%a, %d %b %Y %T %z")
  acl="x-amz-acl:public-read"
  content_type='application/x-compressed-tar'
  string="PUT\n\n$content_type\n$date\n$acl\n/$S3BUCKET$aws_path$file"
  signature=$(echo -en "${string}" | openssl sha1 -hmac "${S3SECRET}" -binary | base64)
  curl -X PUT -T "$BACKUP_DIR/$file" \
    -H "Host: $S3BUCKET.s3-eu-west-1.amazonaws.com" \
    -H "Date: $date" \
    -H "Content-Type: $content_type" \
    -H "$acl" \
    -H "Authorization: AWS ${S3KEY}:$signature" \
    "https://$S3BUCKET.s3-eu-west-1.amazonaws.com$aws_path$file"
}

for file in "$BACKUP_DIR"/*; do
  putS3 "$BACKUP_DIR" "${file##*/}" "/${VDT_APP}/${current_time}/"
done

