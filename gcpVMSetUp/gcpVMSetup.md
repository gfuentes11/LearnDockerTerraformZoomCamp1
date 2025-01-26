### Google Cloud Platform Virtual Machine Setup
The `gcpVMSetup.md` file details the step-by-step process for setting up a GCP Virtual Machine. Below is a summary of the process:
1. **Create an SSH Key**: Follow [this guide](https://cloud.google.com/compute/docs/connect/create-ssh-keys).
2. **Insert SSH Key**: Navigate to Compute > Settings > Metadata and insert the SSH key.
3. **Create a VM Instance**:
   - Use Ubuntu as the OS.
   - Copy the external IP for later use.
4. **Connect to VM via SSH**:
   ```sh
   ssh -i ~/.ssh/<privatekey> <sshkeyNameOnGCP>@<ExternalIPAddress>
   ```
5. **Install Anaconda**:
   ```sh
   wget https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-x86_64.sh
   bash Anaconda3-2024.10-1-Linux-x86_64.sh
   ```
6. **Install Docker**:
   ```sh
   sudo apt-get update
   sudo apt-get install docker.io
   ```
7. **Clone the Git Repository to the VM**.
8. **Run Docker Compose**: Follow the previous setup steps. This will start pgadmdin and pgdb
9. **Create a Conda Environment**: This helps maintain package consistency. Use the one linked in the repo!
10. **Install Terraform on the VM**: To enable running Terraform from the instance itself. 


