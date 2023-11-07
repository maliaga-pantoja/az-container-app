#!/bin/bash

script_load_env ()
{
    source ./devops/scripts/env.sh
}


script_login ()
{
    # loading env file
    script_load_env 
    # configure local env vars
    script_configure_env
    # login to container registry: github
    echo " .. $PAT - $CR_HOST - $GITHUB_ACTOR"
    echo $PAT | docker login $CR_HOST -u $GITHUB_ACTOR --password-stdin
}

"$@"