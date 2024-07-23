#!/bin/bash

# Function to get user input
get_input() {
    read -p "$1: " input
    echo $input
}

# Function to show a message
show_message() {
    echo "======================================="
    echo "$1"
    echo "======================================="
}

# Step 1: Download a container template
template="ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
show_message "Downloading Ubuntu 20.04 template..."
pveam download local $template

# Step 2: Create the container
container_id=$(get_input "Enter the container ID (e.g., 100):")
hostname=$(get_input "Enter the container hostname:")
password=$(get_input "Enter the root password for the container:")
show_message "Creating the container..."
pct create $container_id local:vztmpl/$template --hostname $hostname --storage local-lvm --password $password --start 1 --net0 name=eth0,bridge=vmbr0,ip=dhcp

# Step 3: Allow virtualization nesting
show_message "Enabling virtualization nesting..."
pct set $container_id --features nesting=1

# Step 4: Start the container
show_message "Starting the container..."
pct start $container_id

# Step 5: Install KVM inside the container
show_message "Installing KVM inside the container..."
pct exec $container_id -- bash -c "
apt update -qq && apt install -y -qq qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils cpu-checker
sed -i 's/#remember_owner = 0/remember_owner = 0/' /etc/libvirt/qemu.conf
exit"

# Step 6: Add KVM device to the container's config
show_message "Configuring the container for KVM..."
echo "lxc.cgroup.devices.allow = c 10:232 rwm" >> /etc/pve/lxc/$container_id.conf
echo "lxc.mount.entry = /dev/kvm dev/kvm none bind,create=file,optional 0 0" >> /etc/pve/lxc/$container_id.conf

# Step 7: Restart the container
show_message "Restarting the container..."
pct stop $container_id
pct start $container_id

# Step 8: Verify KVM installation
show_message "Verifying KVM installation..."
pct exec $container_id -- bash -c "
if [ -e /dev/kvm ]; then
    echo '/dev/kvm exists.'
else
    echo '/dev/kvm does not exist. KVM might not be enabled.'
    exit 1
fi

kvm_ok_output=\$(kvm-ok)
echo \"\$kvm_ok_output\"
if [[ \"\$kvm_ok_output\" == *\"KVM acceleration can be used\"* ]]; then
    echo 'KVM is enabled and functioning properly.'
else
    echo 'KVM is not enabled or not functioning properly.'
    exit 1
fi
"

echo "======================================="
echo "Container $hostname (ID: $container_id) has been configured for KVM."
echo "KVM verification completed."
echo "You can now start creating VMs in KVM."
echo "======================================="
