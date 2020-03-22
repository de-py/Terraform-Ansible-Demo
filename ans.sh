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
echo 'domain_controllers:' >> ansible/hosts.yml
echo '        hosts:' >> ansible/hosts.yml
echo '            10.128.0.3' >> ansible/hosts.yml
echo '        vars:' >> ansible/hosts.yml
echo '            ansible_connection: winrm' >> ansible/hosts.yml
echo '            ansible_user: dle_pyc' >> ansible/hosts.yml
echo '            ansible_password: "replace"' >> ansible/hosts.yml
echo '            ansible_winrm_transport: basic' >> ansible/hosts.yml
echo '            ansible_winrm_server_cert_validation: ignore' >> ansible/hosts.yml

# Command to test if connection worked
# ansible windows -m win_command -a "ipconfig"

# Write domain controller playbook file
echo '- name: Domain Controller creation' >> ansible/dc.yml
echo '  hosts: domain_controllers' >> ansible/dc.yml
echo '  serial: 1' >> ansible/dc.yml
echo '' >> ansible/dc.yml
echo '  tasks:' >> ansible/dc.yml
echo '    - name: create or join domain controller' >> ansible/dc.yml
echo '      win_domain:' >> ansible/dc.yml
echo '        dns_domain_name: tform.test' >> ansible/dc.yml
echo '        safe_mode_password: "password123!"' >> ansible/dc.yml
echo '      register: reboot_check' >> ansible/dc.yml
echo '' >> ansible/dc.yml
echo '    - name: check if reboot is needed' >> ansible/dc.yml
echo '      win_reboot:' >> ansible/dc.yml
echo '      when: reboot_check.reboot_required' >> ansible/dc.yml