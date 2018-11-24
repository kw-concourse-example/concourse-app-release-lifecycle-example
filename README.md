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

`Development`: Our app repo has a `develop` branch for ongoing development. Every release gets merged into `master` automatically (and tagged)

# Setup

You will need the pipeline templateer `ctpl` to compile the splitted templates, see more under [ctpl](https://github.com/EugenMayer/concourse-pipeline-templateer)

```console
# templateer
gem install ctpl

# your own local concourse instance with s3 storage, vault and everything else
git clone https://github.com/EugenMayer/concourseci-server-boilerplate

# this pipeline 
git clone concourse-app-release-lifecycle-example
``` 

continue below

## Start your own testing concourse instance

1. Enter `concourseci-server-boilerplate` and run `docker-compose up` to start your local concourse
2. Run `/login.sh` to authenticate your `fly` (user: included1 / password: included1)

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

## Application example strucure

- `code`: code is in this repo [concourse-example-app](https://github.com/kw-concourse-example/concourse-example-app) 
- The CI pipeline files are in this repo at `ci, so [concourse-app-release-lifecycle-example](https://github.com/kw-concourse-example/concourse-app-release-lifecycle-example)

The `code` repo:

Has a develop and master branch. You work should go into `develop` as usual.
Master is used by the ci mainly to make your releases transparent, so it merges develop on release into master.
You can work without this split with only master, in this case remove the `target` for the `tag-and-optional-merge` task 
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

