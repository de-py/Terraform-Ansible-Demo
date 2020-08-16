# Terraform-Ansible Demo

This project is being created to learn and test the capabilities of Terraform and Ansible. The focus of Terraform and Ansible will be to develop a full lab for testing offensive security techniques and detection capabilities. 

## Project Guidelines

Wherever possible this project will try to use infrastructure as code and native configuration management modules to reduce the need for custom scripts. That said, the initial set up of this demo may use scripts until I learn more about the methods for building in configuration. 


## Ideas for machines

* Linux Ansible Controller
* Windows Domain Controller
* Windows Domain Member Server
* Windows Domain Member Workstation
* Linux PKI Host
* Linux Logstash Server
* Linux Elasticsearch Server
* Linux Kibana Server
* HashiCorp Vault


## Manual Steps
07/26/2020 - This section will be updated when more ansible work is complete.

1. Ans.sh should copied to /home/ans.sh. Move this to home directory and run it.
2. Create Administrator password in gcp. Could be scripted but gets error in terraform.
3. RDP into and run winans.ps1 on Windows Server for DC.
4. Update IPs and password in hosts.yml
5. Run ```ansible-playbook dc.yml``` (Can start to add user creation in AD)


## Pre-Deployment Steps
This section is to keep track of where data must be updated before running terraform apply or ansible-playbook. In the future this will be scripted as much as possible.
1. ./ans/Hosts.yml, update external IPs and username (if using local ansible controller)
2. In directory ./elastic/kibana.yml, update kibana with local IP of elastic server for ```elasticsearch.hosts: ["http://localhost:9200"]```
3. In firewall.tf, update source_range on kibana-port to be the NAT address. Temporary until vpn is stood up. Temporary lab either way. 


## Todo
- [] Create kibana.yml with server.host update
- [] Configure authentication on kibana/elastic 
