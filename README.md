# Deployment for personal website

[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://stand-with-ukraine.pp.ua)
![GitHub release (latest SemVer including pre-releases)](https://img.shields.io/github/v/release/fabasoad/business-card-deployment?include_prereleases)
![terraform](https://github.com/fabasoad/business-card-deployment/actions/workflows/terraform.yml/badge.svg)
![security](https://github.com/fabasoad/business-card-deployment/actions/workflows/security.yml/badge.svg)
![linting](https://github.com/fabasoad/business-card-deployment/actions/workflows/linting.yml/badge.svg)

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
