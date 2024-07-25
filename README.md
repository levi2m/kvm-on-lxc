# Proxmox LXC KVM Setup Script 🎉

Welcome to the Proxmox LXC KVM Setup Script repository! This script automates the creation and configuration of an LXC container in Proxmox to support KVM virtualization. 🚀

## Features

- Automatically downloads and sets up an Ubuntu 20.04 LXC container.
- Configures the container for KVM virtualization.
- Installs necessary packages within the container.
- Verifies that KVM is enabled inside the container.

## Prerequisites

Before you start, make sure you have the following:

- A Proxmox VE host with sufficient privileges.
- Internet access to download container templates and packages.

## Usage

### Step 1: Download the Script

Clone this repository to your Proxmox host:

```bash
git clone https://github.com/levi2m/kvm-on-lxc.git
cd kvm-on-lxc
```

### Step 2: Make the Script Executable

```bash
chmod +x setup_kvm_container_proxmox.sh
```

### Step 3: Run the Script

Execute the script and follow the prompts:

```bash
./setup_kvm_container_proxmox.sh
```

What the Script Does

	1.	Download Container Template 📥
	•	Downloads the Ubuntu 20.04 container template

	2.	Create the Container 🏗️
	•	Prompts for a container ID, hostname, and root password.
	•	Creates the container with the specified parameters.
	
	3.	Enable Virtualization Nesting 🔧
	•	Configures the container to allow nested virtualization.
	
 	4.	Start the Container 🚀
	•	Starts the newly created container.
	
 	5.	Install KVM and Dependencies 🛠️
	•	Installs KVM-related packages and tools within the container.
	
 	6.	Configure KVM Device 🔌
	•	Adds necessary device configurations to support KVM.
	
 	7.	Restart the Container 🔄
	•	Restarts the container to apply changes.
	
 	8.	Verify KVM Installation ✅
	•	Checks if KVM is enabled and functioning properly inside the container.

 Example Output

The script will display clear and organized messages throughout the process to keep you informed of each step. Here’s a snippet of what you might see:

```bash
=======================================
Downloading Ubuntu 20.04 template...
=======================================
Creating the container...
=======================================
Enabling virtualization nesting...
=======================================
Starting the container...
=======================================
Installing KVM inside the container...
=======================================
Configuring the container for KVM...
=======================================
Restarting the container...
=======================================
Verifying KVM installation...
/dev/kvm exists.
INFO: /dev/kvm exists
KVM acceleration can be used
KVM is enabled and functioning properly.
=======================================
Container my-container (ID: 100) has been configured for KVM.
KVM verification completed.
You can now start creating VMs in KVM.
=======================================
```

Troubleshooting

If you encounter any issues, please refer to the Proxmox documentation or open an issue in this repository.

Contributions

Feel free to submit pull requests or open issues to contribute to this project. We welcome improvements, bug fixes, and new features!

License

This project is licensed under the MIT License. See the LICENSE file for details.

Happy virtualizing! 🎉


