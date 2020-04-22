# Terraform (and Ansible) Demo

This project is being created to learn and test the capabilities of Terraform and Ansible. The focus of Terraform and Ansible will be to develop a full lab for testing offensive security techniques and detection capabilities. 

## Project Guidelines

Wherever possible this project will try to use infrastructure as code and native configuration management modules to reduce the need for custom scripts. That said, the initial set up of this demo may use scripts until I learn more about the methods for building in configuration. 


## Ideas for machines

* Linux Ansible Controller
* Domain Controller
* Member Server
* Member Workstation
* Linux PKI Host
* Linux Logstash Server
* Linux Elasticsearch Server
* Kibana Server
* HashiCorp Vault


## Manual Steps

1. Ans.sh should copied to /home/ans.sh. Move this to home directory and run it.
2. Create Administrator password in gcp. Could be scripted but gets error in terraform.
3. RDP into and run winans.ps1 on Windows Server for DC.
4. Update IPs and password in hosts.yml
5. Run ```ansible-playbook dc.yml``` (Can start to add user creation in AD)