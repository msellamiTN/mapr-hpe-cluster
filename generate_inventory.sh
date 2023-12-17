#!/bin/bash

# Define the inventory file
INVENTORY_FILE="inventory/hosts"

# Clear the existing inventory file
 
# Get VM names and information
VBoxManage list vms | awk -F\" '{print $2}' | xargs -n1 -I {} sh -c '
    VM_NAME=$(echo "{}" | awk -F_ "{print \$2}")
    NIC_RULE=$(VBoxManage showvminfo "{}" | grep -E "NIC")

    if [ -n "$NIC_RULE" ]; then
        # Extract components using awk
        NAME=$(echo "$NIC_RULE" | awk -F"name = " "{print \$2}" | awk -F, "{print \$1}")
        PROTOCOL=$(echo "$NIC_RULE" | awk -F"protocol = " "{print \$2}" | awk -F, "{print \$1}")
        HOST_IP=$(echo "$NIC_RULE" | awk -F"host ip = " "{print \$2}" | awk -F, "{print \$1}")
        HOST_PORT=$(echo "$NIC_RULE" | awk -F"host port = " "{print \$2}" | awk -F, "{print \$1}")

        # Define Ansible variables
        MAPR_UID=1001
        MAPR_GID=1001
        MAPR_USER=mapr

        # Append to the inventory file
        echo   "[$VM_NAME]\n$VM_NAME   MAPR_UID=$MAPR_UID MAPR_GID=$MAPR_GID MAPR_USER=$MAPR_USER ansible_host=$HOST_IP ansible_port=$HOST_PORT ansible_user=vagrant ansible_ssh_private_key_file=/home/user2/mapr-cluster/.ssh/id_rsa\n"  
    else
        echo "VM Name: $VM_NAME - No NIC 1 Rule(0) found."
    fi
'

# Define other groups and variables as needed
echo  "\n# Add other hosts as needed\n[mapr-edge:vars]\nMAPR_UID=1001\nMAPR_GID=1001\nMAPR_USER=mapr"  
