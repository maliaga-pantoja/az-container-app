#!/bin/bash

script_load_env ()
{
    source ./devops/scripts/env.sh
}


script_build ()
{
    # loading env file
    script_load_env
    # configure local env vars
    script_configure_env
    docker build -t $IMAGE_NAME:$IMAGE_TAG ./app
    docker tag $IMAGE_NAME:$IMAGE_TAG $IMAGE_NAME:latest
}
x
"$@"