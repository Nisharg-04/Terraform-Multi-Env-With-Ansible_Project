#!/bin/bash
############################################
# Author: 	Nisharg Soni
# Date: 	2024-12-28
# Version:	1.0
# Description: Cleanup script
# Usage:	./cleanup.sh
############################################

set -e
function terraform_destroy {
    cd terraform
    terraform destroy -auto-approve
    cd ..
}

terraform_destroy

echo "Cleanup completed successfully"
