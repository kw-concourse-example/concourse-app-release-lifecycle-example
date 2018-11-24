# WAT

# Setup

1.  checkout `https://github.com/EugenMayer/concourseci-server-boilerplate` and run `docker-compose up`
2. run `./login.sh`
3. Back to `concourse-app-release-lifecycle-example`
3. Create a `.variables.yaml` and see the `.variables.yaml` section below
3. Run `make ci-p-deploy` to generate and deploy the pipeline ( and rerun if you do changes )
4. Connect to `http://localhost:9001/minio` with credentials minio / changeme
5. Create the bucket `myapp` ( + sign in the bottom right corner )

 
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

