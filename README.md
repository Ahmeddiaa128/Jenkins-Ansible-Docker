# Jenkins-Ansible-Docker
## Project Overview
### Objective:
The objective of this project is to automate the deployment and configuration of an Apache server on a VirtualBox-hosted VM using Jenkins CI/CD pipelines, Ansible, and Docker. This setup integrates essential DevOps practices to streamline deployment, configuration management, and notification processes, all while maintaining a version-controlled environment.
### Project Components:
User Management on VM3 (Apache Server on VirtualBox):

Script: CreateUsers.sh
Functionality: This script creates designated users (Devo, Testo, and Prodo) on the Apache server (VM3) and adds them to a centralized group, deployG, for simplified access control and user management.
GitHub Repository Setup:

Contains essential configuration files for automation, including:
InstallApache.yml: An Ansible playbook that installs and configures the Apache web server on VM3.
NotGroupMembers.sh: A Bash script to list users who are not part of the deployG group on VM3.
CI/CD Pipeline Configuration:

Pipeline Tool: Jenkins
Jenkinsfile:
Stage 1 - Ansible Execution: Runs InstallApache.yml to install and configure Apache on VM3.
Stage 2 - Docker Image Build and Archive:
Builds a Docker image based on a specified Dockerfile.
Saves the Docker image locally as <image_name>.tar.
Stage 3 - Email Notification:
Sends an email with the pipeline status, a list of users in the deployG group, the date and time of execution, and the path to the Docker image tar file.
### Project Workflow:
User and Group Management:

The CreateUsers.sh script is executed on VM3 to create and organize users under the deployG group.
Configuration Management and Deployment:

The Jenkins pipeline triggers InstallApache.yml via Ansible to configure Apache, ensuring that it is installed, started, and enabled to run on boot.
Build and Archive Docker Image:

A Docker image is built according to the project’s Dockerfile and is saved as an archive (.tar) in a shared location for future use.
Email Notification:

Once the pipeline completes, Jenkins sends an email summarizing the deployment status, listing users in deployG, and providing a link to the Docker image archive.
### Infrastructure Requirements:
VM3 (Apache Server):
IP Address: 192.168.56.113
Port: 8080 (for Apache access)
Username: apache
Virtualization Platform: VirtualBox
Networking: Bridged or NAT with Port Forwarding (to ensure Jenkins can access the VM via SSH)
### Key Technologies Used:
Jenkins: Automates the CI/CD pipeline for consistent, streamlined deployments.
Ansible: Manages the configuration of Apache on VM3, ensuring that the web server is properly set up.
Docker: Builds, archives, and maintains Docker images for versioned deployment.
Bash: Provides user and group management scripts for easy access control on VM3.
### Outcome:

With this setup, we establish an automated deployment and configuration management pipeline that not only deploys an Apache web server but also archives Docker images and sends deployment status notifications. This enables efficient development and operations workflows, reducing the manual effort needed to manage and configure the Apache server.

