# oidc-actions

## Usage

```console
# prepare
$ terraform init

# create oidc provider on AWS
$ make plan
$ make apply

# clean up
$ make destroy
```

Run [Workflow](https://github.com/blue0513/oidc-actions/actions/workflows/ci.yml) by `workflow_dispatch`

## Thanks

https://zenn.dev/nameless_gyoza/articles/github-actions-aws-oidc-by-terraform
