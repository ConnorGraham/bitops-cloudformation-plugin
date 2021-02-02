#!/usr/bin/env bash
set -e

bash $PLUGIN_DIR/scripts/validate_env.sh

echo "cd cloudformation Root: $ENVIRONMENT_DIR"
cd $ENVIRONMENT_DIR

# always run cfn template validation first
if [[ "${CFN_TEMPLATE_VALIDATION}" == "True" ]] || [[ "${CFN_TEMPLATE_VALIDATION}" == "true" ]]; then
  echo "Running Cloudformation Template Validation"
  bash $PLUGIN_DIR/scripts/cloudformation_validate.sh "$CFN_TEMPLATE_FILENAME"
fi

if [[ "${CFN_STACK_ACTION}" == "deploy" ]] || [[ "${CFN_STACK_ACTION}" == "Deploy" ]]; then
  echo "Running Cloudformation Deploy Stack"
  bash $PLUGIN_DIR/scripts/cloudformation_deploy.sh "$CFN_TEMPLATE_FILENAME" "$CFN_PARAMS_FLAG" "$CFN_TEMPLATE_PARAMS_FILENAME" "$CFN_STACK_NAME" "$CFN_CAPABILITY" "$CFN_TEMPLATE_S3_BUCKET" "$CFN_S3_PREFIX"
fi

if [[ "${CFN_STACK_ACTION}" == "delete" ]] || [[ "${CFN_STACK_ACTION}" == "Delete" ]]; then
  echo "Running Cloudformation Delete Stack"
  bash $PLUGIN_DIR/scripts/cloudformation_delete.sh "$CFN_STACK_NAME"
fi