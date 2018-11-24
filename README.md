# WAT

This `concourse pipeline` should show an example application build lifecycle including 

 - staging builds
 - candidate builds
 - release builds
 
`Versions`: It includes versioning for all 3 stages and also manual "promoting" of e.g staging builds to candidates
and later promoting candidates to releases.

`Artificats`: It stores your artifacts on your local minio (s3) storage for proper concourse resource handling

`Promoting`: Shows how to "repackage"/inject the candidate version into the staging build, so proper repackaing, to rebuilding. Ensures you deploy what you tested

`Tagging`: It includes tagging of the src repo on release to visualize what has been released when.

`Traceability`: It includes the shasum and the version in the `app code artifact` 

# Setup

## Start your own testing concourse instance

1. Checkout `https://github.com/EugenMayer/concourseci-server-boilerplate`
1. Enter `concourseci-server-boilerplate` and run `docker-compose up`
2. Run `/login.sh`

## Deploy this pipeline to your new concourse 
1. Back to `concourse-app-release-lifecycle-example`
1. Create a `.variables.yaml` and see the `.variables.yaml` section below
1. Run `make ci-p-deploy` to generate and deploy the pipeline ( and rerun if you do changes )
1. Connect to `http://localhost:9001/minio` with credentials minio / changeme
1. Create the bucket `myapp` ( + sign in the bottom right corner )

 
Your done :) Start the job 

## Splitted pipeline files?

You find the pipeline files splitted in `ci/pipeline` for better readability and semantic grouping
Those files are compiled using [ctpl](https://github.com/EugenMayer/concourse-pipeline-templateer)

## .variables.yaml

```yaml
github-private-key: |
  -----BEGIN RSA PRIVATE KEY-----
  your private ssh key for the repo
  -----END RSA PRIVATE KEY-----

docker-registry:
  user: <your docker registry user>
  password: <your docker registry password>

app:
  docker-image: kwexample/concourse-example-app
  git-repo: git@github.com:kw-concourse-example/concourse-example-app

ci:
  git-repo: git@github.com:kw-concourse-example/concourse-app-release-lifecycle-example
```

