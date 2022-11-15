#!/bin/bash

TAG=$1
BUCKET=$2

echo "The version is $TAG"
echo "The bucket is $BUCKET"

git archive --remote=git@bitbucket.org:kycutility/srv_kycutility.git $TAG "admin/operations/report/templates/" | tar -x

aws s3 cp "admin/operations/report/templates/full-configured.html" s3://$BUCKET/templates/full-configured.html
aws s3 cp "admin/operations/report/templates/full-configured.text" s3://$BUCKET/templates/full-configured.text
aws s3 cp "admin/operations/report/templates/full-unconfigured.html" s3://$BUCKET/templates/full-unconfigured.html
aws s3 cp "admin/operations/report/templates/full-unconfigured.text" s3://$BUCKET/templates/full-unconfigured.text

rm -drf admin
