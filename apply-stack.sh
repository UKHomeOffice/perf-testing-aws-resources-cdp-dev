#!/usr/bin/env sh

source parameters.sh

export STACK_NAME=${PREFIX}${ENVIRONMENT}-perf-tests

echo "stack name: $STACK_NAME"


if aws cloudformation describe-stacks --stack-name $STACK_NAME; then
    echo 'Stack exists; updating it'
    if ! aws cloudformation update-stack --stack-name $STACK_NAME \
        --capabilities CAPABILITY_NAMED_IAM \
        --template-body "`cat cf-template.yml`" \
        --parameters "ParameterKey=Prefix,ParameterValue=$PREFIX" \
            "ParameterKey=Environment,ParameterValue=$ENVIRONMENT" ; then
        STATUS=$?
        echo update failed
        exit $STATUS
    fi
else
    echo 'Stack does not exist; creating it'
    aws cloudformation create-stack --stack-name $STACK_NAME \
        --capabilities CAPABILITY_NAMED_IAM \
        --template-body "`cat cf-template.yml`" \
        --parameters "ParameterKey=Prefix,ParameterValue=$PREFIX" \
            "ParameterKey=Environment,ParameterValue=$ENVIRONMENT"
fi

echo 'waiting for the stack to exist'
aws cloudformation wait stack-exists --stack-name $STACK_NAME