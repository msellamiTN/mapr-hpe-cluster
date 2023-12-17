#!/bin/bash

# Get VM names and information
VBoxManage list vms | awk -F\" '{print $2}' | xargs -n1 -I {} sh -c '
    VM_NAME=$(echo "{}" | awk -F_ "{print \$2}")
    NIC_RULE=$(VBoxManage showvminfo "{}" | grep -E "NIC 1 Rule\(0\)")

    if [ -n "$NIC_RULE" ]; then
        # Extract components using awk
        NAME=$(echo "$NIC_RULE" | awk -F"name = " "{print \$2}" | awk -F, "{print \$1}")
        PROTOCOL=$(echo "$NIC_RULE" | awk -F"protocol = " "{print \$2}" | awk -F, "{print \$1}")
        HOST_IP=$(echo "$NIC_RULE" | awk -F"host ip = " "{print \$2}" | awk -F, "{print \$1}")
        HOST_PORT=$(echo "$NIC_RULE" | awk -F"host port = " "{print \$2}" | awk -F, "{print \$1}")
        GUEST_IP=$(echo "$NIC_RULE" | awk -F"guest ip = " "{print \$2}" | awk -F, "{print \$1}")
        GUEST_PORT=$(echo "$NIC_RULE" | awk -F"guest port = " "{print \$2}" | awk -F, "{print \$1}")

        echo "VM Name: $VM_NAME, Name: $NAME, Protocol: $PROTOCOL, Host IP: $HOST_IP, Host Port: $HOST_PORT, Guest IP: $GUEST_IP, Guest Port: $GUEST_PORT"
    else
        echo "VM Name: $VM_NAME - No NIC 1 Rule(0) found."
    fi
'
