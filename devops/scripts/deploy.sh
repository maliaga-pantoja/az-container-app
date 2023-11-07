#!/bin/bash

script_load_env ()
{
    source ./devops/scripts/env.sh
}


script_image_deploy ()
{
    # loading env file
    script_load_env
    # configure local env vars
    script_configure_env

    docker push -a $GITHUB_CR/$IMAGE_NAME:$IMAGE_TAG
}