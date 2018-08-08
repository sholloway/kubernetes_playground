#!/usr/bin/env bash 


echo '--------------------------------------------------------------------------------'
echo 'Setting up the local development environment.'

echo 'Setting local variables'

echo 'Adding Aliases'
alias create_scratch_org=''

echo 'Defining Functions'

function k_help(){
    local msg=$(cat << EOM
|-- Manage Orgs ---------------------------------------------------------------|
| Function           | Purpose                                                 |
|--------------------|---------------------------------------------------------|
| login              | Log in to the Dev Hub org via the Web Flow.             | 
| create_scratch_org | Create a scratch org.                                   | 
| open_scratch       | Open the scratch org in a browser.                      | 
| list_orgs          | List all connected orgs.                                | 
--------------------------------------------------------------------------------
EOM
)
  echo "$msg"
}

echo 'Environment setup is complete.'
echo '--------------------------------------------------------------------------------'
echo 'Run k_help to see a list of available commands.'
echo '--------------------------------------------------------------------------------'