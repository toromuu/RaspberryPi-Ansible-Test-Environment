#!/bin/bash

ENV=localdocker
 
docker-compose up -d
 
export MSYS_NO_PATHCONV=1

ansible_cmd="ansible-playbook -v -i /inventory -e 'version=release' --ask-pass --ask-vault-pass /playbook/PlaybookDeploy.yml"

docker run --rm -ti \
    --network host \
    -v "$PWD/../projectNameFolderInventory":/inventory \
    -v "$PWD/../projectNameFolderPlaybook/":/playbook \
    -e "ENV=${ENV}" \
    -e "ANSIBLE_HOST_KEY_CHECKING=False" \
    willhallonline/ansible:2.9-alpine \
    sh -c "${ansible_cmd}"