# perf-testing-aws-resources-cdp-dev

Creates a bucket for holding performance testing data for the cdp-dev environment.

This repo contains configuration data for the cdp-dev environment and leverages the code in
[perf-testing-aws-resources](https://github.com/UKHomeOffice/perf-testing-aws-resources)

A CloudFormation stack is created to manage:
* S3 bucket for the performance data
* IAM roles and policies for managing objects in the S3 bucket

In order to set up resources for another environment, the variables in [`parameters.sh`](parameters.sh) should be amended.
