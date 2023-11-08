#!/bin/bash

script_load_env ()
{
    source ./devops/scripts/env.sh
}

script_security ()
{
    # loading env file
    script_load_env 
    # configure local env vars
    script_configure_env
    # running base tf script
    docker run --rm -it -e SNYK_TOKEN=$SNYK_TOKEN -v "$PWD/iac:/app" \
        -w /app snyk/snyk:alpine "/usr/local/bin/snyk iac test --json --json-file-output=vuln.json"
}

"$@"