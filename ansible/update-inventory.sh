#!/bin/bash
#!/bin/bash
############################################
# Author: 	Nisharg Soni
# Date: 	2024-12-28
# Version:	1.0
# Description: Update Ansible inventory
# Usage:	./update-inventory.sh
############################################




TERRAFORM_OUTPUT_DIR="../terraform"  
ANSIBLE_INVENTORY_DIR="./inventories"


cd "$TERRAFORM_OUTPUT_DIR" || { echo "Terraform directory not found"; exit 1; }

DEV_IPS=$(terraform output -json dev_infra_ec2_public_ips | jq -r '.[]')
STG_IPS=$(terraform output -json stg_infra_ec2_public_ips | jq -r '.[]')
PRD_IPS=$(terraform output -json prd_infra_ec2_public_ips | jq -r '.[]')





update_inventory_file() {
    local ips="$1"
    local inventory_file="$2"
    local env="$3"
    # Create or clear the inventory file
    > "$inventory_file"

    # Write the inventory header
    echo "[servers]" >> "$inventory_file"

    # Add dynamic hosts based on IPs
    local count=1
    for ip in $ips; do
        echo "server${count} ansible_host=$ip" >> "$inventory_file"
        count=$((count + 1))
    done

    # Add common variables
    echo "" >> "$inventory_file"
    echo "[servers:vars]" >> "$inventory_file"
    echo "ansible_user=ubuntu" >> "$inventory_file"
    echo "ansible_ssh_private_key_file=/tmp/devops-key" >> "$inventory_file"
    echo "ansible_ssh_extra_args='-o StrictHostKeyChecking=no'" >> "$inventory_file"
    echo "ansible_python_interpreter=/usr/bin/python3" >> "$inventory_file"

    echo "Updated $env inventory: $inventory_file"
}

# Update each inventory file
cd "../ansible" || { echo "Ansible directory not found"; exit 1; }

update_inventory_file "$DEV_IPS" "$ANSIBLE_INVENTORY_DIR/dev" "dev"
update_inventory_file "$STG_IPS" "$ANSIBLE_INVENTORY_DIR/stg" "stg"
update_inventory_file "$PRD_IPS" "$ANSIBLE_INVENTORY_DIR/prd" "prd"

echo "All inventory files updated successfully!"