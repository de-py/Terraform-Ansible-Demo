# Install updates
sudo yum -y update

# Install ansible
pip3 install --user ansible

# Install pywinrm module for /home/ansible/windows connection
pip3 install --user "pywinrm>=0.3.0"

# Create ansible directory
mkdir /home/ansible

# Write ansible config file
echo '[defaults]' >> /home/ansible/ansible.cfg
echo 'inventory = hosts.yml' >> /home/ansible/ansible.cfg

# Write ansible inventory file, make sure to update IP and password
echo 'domain_controllers:' >> /home/ansible/hosts.yml
echo '        hosts:' >> /home/ansible/hosts.yml
echo '            10.128.0.3' >> /home/ansible/hosts.yml
echo '        vars:' >> /home/ansible/hosts.yml
echo '            ansible_connection: winrm' >> /home/ansible/hosts.yml
echo '            ansible_user: dle_pyc' >> /home/ansible/hosts.yml
echo '            ansible_password: "replace"' >> /home/ansible/hosts.yml
echo '            ansible_winrm_transport: basic' >> /home/ansible/hosts.yml
echo '            ansible_winrm_server_cert_validation: ignore' >> /home/ansible/hosts.yml

# Command to test if connection worked
# ansible windows -m win_command -a "ipconfig"

# Write domain controller playbook file
echo '- name: Domain Controller creation' >> /home/ansible/dc.yml
echo '  hosts: domain_controllers' >> /home/ansible/dc.yml
echo '  serial: 1' >> /home/ansible/dc.yml
echo '' >> /home/ansible/dc.yml
echo '  tasks:' >> /home/ansible/dc.yml
echo '    - name: create or join domain controller' >> /home/ansible/dc.yml
echo '      win_domain:' >> /home/ansible/dc.yml
echo '        dns_domain_name: tform.test' >> /home/ansible/dc.yml
echo '        safe_mode_password: "password123!"' >> /home/ansible/dc.yml
echo '      register: reboot_check' >> /home/ansible/dc.yml
echo '' >> /home/ansible/dc.yml
echo '    - name: check if reboot is needed' >> /home/ansible/dc.yml
echo '      win_reboot:' >> /home/ansible/dc.yml
echo '      when: reboot_check.reboot_required' >> /home/ansible/dc.yml