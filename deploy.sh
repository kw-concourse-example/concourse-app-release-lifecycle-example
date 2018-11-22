#!/usr/bin/env bash

fly sp -t test_main configure -l .variables.yaml -c ci/pipeline.yaml -p app-release-lifecycle