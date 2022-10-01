#!/bin/bash
# Specify the S3 Bucket created after deployment and the region
S3Bucket=
REGION=
sam build --use-container
sam package --output-template-file packaged.yaml --s3-bucket $S3Bucket
sam deploy --template-file packaged.yaml --stack-name docusign-api --s3-bucket $S3Bucket --capabilities CAPABILITY_IAM --region $REGION --no-confirm-changeset
