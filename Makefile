.PHONY: help
S3_BUCKET=
SAMBucket=
REGION=eu-west-3
STACK_NAME=
LAMBDA=

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

build:
	sam build --use-container

logs:
	sam logs -n ${LAMBDA} --stack-name ${STACK_NAME} --tail

test:
	python -m pytest tests -v

local:
	sam build --use-container
	sam local start-api

update:
	sam build --use-container
	sam package --output-template-file packaged.yaml --s3-bucket ${SAMBucket}
	sam deploy --template-file packaged.yaml --stack-name ${STACK_NAME} --s3-bucket ${SAMBucket} --capabilities CAPABILITY_IAM --region $REGION --no-confirm-changeset

emtpy:
	aws s3 rm $S3_BUCKET --recursive

remove:
	aws cloudformation delete-stack --stack-name ${STACK_NAME}

describe:
	aws cloudformation describe-stack-resources --stack-name docusign-api --query "StackResources[4].PhysicalResourceId" --output json | jq
