# Install updates
sudo yum -y update

# Install ansible
pip3 install --user ansible

# Install pywinrm module for ansible/windows connection
pip3 install --user "pywinrm>=0.3.0"

# Create ansible directory
mkdir ansible

# Write ansible config file
echo '[defaults]' >> ansible/ansible.cfg
echo 'inventory = hosts.yml' >> ansible/ansible.cfg

# Write ansible inventory file, make sure to update IP and password
echo 'windows:' >> ansible/hosts.yml
echo 'hosts:' >> ansible/hosts.yml
echo '10.128.0.2' >> ansible/hosts.yml
echo 'vars:' >> ansible/hosts.yml
echo 'ansible_connection: winrm' >> ansible/hosts.yml
echo 'ansible_user: dle_pyc' >> ansible/hosts.yml
echo 'ansible_password: "updatepassword"' >> ansible/hosts.yml
echo 'ansible_winrm_transport: basic' >> ansible/hosts.yml
echo 'ansible_winrm_server_cert_validation: ignore' >> ansible/hosts.yml

ansible windows -m win_command -a "ipconfig"
