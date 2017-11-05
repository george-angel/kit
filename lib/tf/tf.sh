#!/bin/bash

set -e

TF_VER="0.10.7"

repo_base_path="$(git rev-parse --show-toplevel)"
component_relative_path="${PWD#$repo_base_path/}"

exec docker run --rm -ti \
  -v "${repo_base_path}":/data \
  -v "${HOME}/.aws":/root/.aws:ro \
  -w "/data/${component_relative_path}" \
  -e AWS_PROFILE="${AWS_PROFILE}" \
  -e AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" \
  -e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" \
  -e SCALEWAY_TOKEN="${SCALEWAY_TOKEN}" \
  -e SCALEWAY_ORGANIZATION="${SCALEWAY_ORGANIZATION}" \
  -e TF_VAR_date="${DATE:-$(date +%D)}" \
  -e TF_VAR_component="${TF_VAR_component}" \
  -e TF_PLUGIN_CACHE_DIR=/data/.terraform_plugin_cache \
  hashicorp/terraform:${TF_VER} "$@"
