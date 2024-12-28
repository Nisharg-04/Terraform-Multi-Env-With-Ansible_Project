#!/bin/bash
############################################
# Author: 	Nisharg Soni
# Date: 	2024-12-28
# Version:	1.0
# Description:	Complete project script
# Usage:	./complete-project.sh
############################################

set -e
function terraform_config {
    cd terraform
    terraform init
    terraform apply -auto-approve
    cd ..
}
function ansible_config {
    cd ansible
    ./update-inventory.sh
    ansible-playbook -i inventories/dev playbooks/nginx-playbook.yml
    ansible-playbook -i inventories/stg playbooks/nginx-playbook.yml
    ansible-playbook -i inventories/prd playbooks/nginx-playbook.yml
    cd ..
}

terraform_config
ansible_config

echo "Project completed successfully"
