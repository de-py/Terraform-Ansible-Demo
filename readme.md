# Terraform-Ansible Demo

This project is being created to learn and test the capabilities of Terraform and Ansible. The focus of Terraform and Ansible will be to develop a full lab for testing offensive security techniques and detection capabilities. 

## Project Guidelines

Wherever possible this project will use infrastructure as code and native configuration management modules to reduce the need for custom scripts and manual tasks. 


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


## Pre-Deployment Steps
This section is to keep track of where data must be updated before running terraform apply or ansible-playbook. These steps will need to be automated in a way that meets the project guidelines.

1. Up Inventory from Terraform Output
2. In directory ./elastic/kibana.yml, update kibana with local IP of elastic server for ```elasticsearch.hosts: ["http://<changeme>:9200"]```
3. In firewall.tf, update source_range on kibana-port to be the NAT address of the server that's browsing to Kibana. 


## Todo
- [ ] Create kibana.yml with server.host update
- [ ] Configure authentication on kibana/elastic 
- [ ] Create script to automate terraform output to ansible inventory
- [ ] Make ELK config files into templates and pull IPs into variables that can be updated with a script easily
- [ ] Delete old project files
