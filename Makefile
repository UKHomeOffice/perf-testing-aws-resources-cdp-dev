.PHONY: all alpine-all rebuild alpine-rebuild clean alpine-git alpine-apply-stack \
apply-stack cf-template delete-stack venv git-repo

all: alpine-apply-stack

alpine-all: alpine-apply-stack

rebuild: clean apply-stack

alpine-rebuild: clean alpine-apply-stack

clean:
	rm -rf venv || true
	rm -rf perf-testing-aws-resources || true
	rm attributes.yml || true
	rm cf-template.yml || true

alpine-git:
	git --version || apk add --no-cache git

alpine-apply-stack: alpine-git apply-stack

apply-stack: git-repo cf-template
	. venv/bin/activate && \
	. apply-stack.sh

cf-template: ./cf-template.yml

./cf-template.yml: venv git-repo
	. venv/bin/activate && \
	python perf-testing-aws-resources/generate_cf_template.py > cf-template.yml

delete-stack:
	# aws cloudformation delete-stack --stack-name budget-alerts
	# aws cloudformation wait stack-delete-complete --stack-name budget-alerts
	echo 'not yet implemented'

./venv/: git-repo
	python3 -m venv venv
	. venv/bin/activate && cd perf-testing-aws-resources && pip install -r requirements.txt

venv: ./venv/

git-repo: ./perf-testing-aws-resources

./perf-testing-aws-resources:
	git clone --depth 1 https://github.com/UKHomeOffice/perf-testing-aws-resources.git
