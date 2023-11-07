#!/bin/sh

script_load_env ()
{
    source ./devops/scripts/env.sh
}


script_terraform ()
{
    # loading env file
    script_load_env
    # configure local env vars
    script_configure_env
    # running base tf script
    docker run -v "$PWD/iac:/app" \
        -e ARM_CLIENT_ID=$ARM_CLIENT_ID \
        -e ARM_CLIENT_SECRET=$ARM_CLIENT_SECRET \
        -e ARM_TENANT_ID=$ARM_TENANT_ID \
        -e ARM_SUBSCRIPTION_ID=$ARM_SUBSCRIPTION_ID \
        -e TF_VAR_PROJECT_NAME=$PROJECT_NAME  \
        -e TF_VAR_REGION=$REGION \
        -e TF_VAR_IMAGE_NAME=$IMAGE_NAME \
        -e TF_VAR_IMAGE_TAG=$IMAGE_TAG  \
        -w /app \
    hashicorp/terraform:1.6 $1
}

script_terraform_init () 
{
    script_terraform "init"
}

script_terraform_plan () 
{
    script_terraform "plan"
}

script_terraform_apply () 
{
    script_terraform "apply -auto-approve"
}

script_terraform_destroy () 
{
    script_terraform "destroy -auto-approve"
}

script_terraform_output () 
{
    script_terraform "output"
}

"$@"