# Deployment for personal website

<!-- markdownlint-disable-next-line MD013 -->
![Analysis](https://github.com/fabasoad/business-card-deployment/workflows/Analysis/badge.svg)
![Terraform Lint](https://github.com/fabasoad/business-card-deployment/workflows/Terraform%20Lint/badge.svg)
![Terraform](https://github.com/fabasoad/business-card-deployment/workflows/Terraform/badge.svg)

Deployment repo for <https://github.com/fabasoad/business-card/> project

## Work locally

### Install hooks

- Install the pre-commit from <https://pre-commit.com/>
- Install the pre-commit configuration

```shell
pre-commit install
```

### Deploy

> Be sure that `business-card-development` repository is on the same level as
> `business-card` repository.

Run the following commands:

```shell
./build_bundle.sh
cd terraform
terraform init
terraform plan
terraform apply
```
