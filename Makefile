
ci-p-build:
	# ctpl -b ci/pipeline -o ci/pipeline.yaml
	cd ci && ctpl


ci-p-deploy: ci-p-build
	fly sp -t test_main configure -l .variables.yaml -c ci/pipeline.yaml -p app-release-lifecycle
