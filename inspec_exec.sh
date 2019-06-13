source parameters.sh
echo "prefix: \"${PREFIX}\"" > attributes.yml
echo "environment: \"${ENVIRONMENT}\"" >> attributes.yml
inspec exec --chef-license=accept-silent --input-file=attributes.yml --target=aws:// perf-testing-aws-resources/perf-test-inspec