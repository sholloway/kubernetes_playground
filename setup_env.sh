#!/usr/bin/env bash 
echo '--------------------------------------------------------------------------------'
echo 'Setting up the local development environment.'

echo 'Setting local variables'

echo 'Adding Aliases'
#alias build_node_app=''

echo 'Defining Functions'
function build_node_app(){
    pushd ./apps/simple_node_app
    # Note: For day to day development, leverage tags on your apps.
    # e.g. docker build -t node_app:0.0.1 . 
    docker build -t simple_node_app .
    popd
}

function k_help(){
    local msg=$(cat << EOM
|-- Manage Apps ---------------------------------------------------------------|
| Function           | Purpose                                                 |
|--------------------|---------------------------------------------------------|
| build_node_app     | Creates a Docker image for the example Node.js app.     | 
--------------------------------------------------------------------------------
EOM
)
  echo "$msg"
}

echo 'Environment setup is complete.'
echo '--------------------------------------------------------------------------------'
echo 'Run k_help to see a list of available commands.'
echo '--------------------------------------------------------------------------------'