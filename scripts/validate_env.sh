#!/usr/bin/env bash
set -e 

if [ -n "$SKIP_DEPLOY_CLOUDFORMATION" ]; then
  echo "SKIP_DEPLOY_CLOUDFORMATION set..."
  exit 0
fi

if [ ! -d "$ENVIRONMENT_DIR" ]; then
  echo "No terraform directory.  Skipping."
  exit 0
fi

# Exit if Stack Name not found
if [[ "${CFN_STACK_NAME=}" == "" ]] || [[ "${CFN_STACK_NAME=}" == "''" ]] || [[ "${CFN_STACK_NAME=}" == "None" ]]; then
  >&2 echo "{\"error\":\"$CFN_STACK_NAME config is required in bitops config.Exiting...\"}"
  exit 1
fi

# Exit if CFN Template Filename is not found
if [[ "${CFN_TEMPLATE_FILENAME==}" == "" ]] || [[ "${CFN_TEMPLATE_FILENAME==}" == "''" ]] || [[ "${CFN_TEMPLATE_FILENAME==}" == "None" ]]; then
  >&2 echo "{\"error\":\"$CFN_TEMPLATE_FILENAME config is required in bitops config.Exiting...\"}"
  exit 1
fi

# Exit if CFN Template Parameters Filename is not found
if [[ "${CFN_PARAMS_FLAG}" == "True" ]] || [[ "${CFN_PARAMS_FLAG}" == "true" ]]; then
  if [[ "${CFN_TEMPLATE_PARAMS_FILENAME}" == "" ]] || [[ "${CFN_TEMPLATE_PARAMS_FILENAME}" == "''" ]] || [[ "${CFN_TEMPLATE_PARAMS_FILENAME}" == "None" ]]; then
    >&2 echo "{\"error\":\"$CFN_TEMPLATE_FILENAME config is required in bitops config.Exiting...\"}"
    exit 1
  fi
fi