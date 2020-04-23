# # Install updates
# sudo yum -y update

# Install ansible
pip3 install --user ansible

# Install pywinrm module for ansible/windows connection
pip3 install --user "pywinrm>=0.3.0"

# Create ansible directory
mkdir ansible

# Write ansible config file
curl -s https://raw.githubusercontent.com/de-py/Terraform-Demo/master/ans/ansible.cfg > ansible/ansible.cfg

# Write ansible inventory file, make sure to update IP and password
curl -s https://raw.githubusercontent.com/de-py/Terraform-Demo/master/ans/hosts.yml > ansible/dc.yml


# Command to test if connection worked
# ansible windows -m win_command -a "ipconfig"

# Write domain controller playbook file
curl -s https://raw.githubusercontent.com/de-py/Terraform-Demo/master/ans/dc.yml > ansible/dc.yml
