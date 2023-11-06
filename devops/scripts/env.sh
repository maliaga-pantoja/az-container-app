#!/bin/bash
script_configure_env () 
{
    REPONAME="${GITHUB_REPOSITORY:-owner/repo}"
    export PROJECT_NAME=$(echo $REPONAME | cut -d "/" -f2)
    export IMAGE_NAME=$PROJECT_NAME
    export REGION="${REGION:-EASTUS}"
    export IMAGE_TAG="${GITHUB_SHA:-latest}"
}

"$@"