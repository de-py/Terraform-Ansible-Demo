#!/usr/bin/python3
import subprocess
import inspect

def elk():
    name = 'elk'
    # Run Terraform Output Elk from cli 
    process = subprocess.Popen(['terraform','output','elk'], stdout=subprocess.PIPE)
    stdout, stderr = process.communicate()

    # Filter extra characters and assignt to list
    bad_chars = ['\n  ',',\n','\n','[',']','"']
    elk_ips = stdout.decode('ascii')
    for i in bad_chars:
        elk_ips = elk_ips.replace(i,'')
    elk_ips = elk_ips.split(',')

    # Print in ansible format
    f = open("../ansible/inventory/hosts.yml","w")
    f.write('[%s]\n' % name)
    for ip in elk_ips:
        f.write('%s\n' % ip)

    f.write('[%s:vars]\n' % name)
    f.write('%s\n' % 'ansible_user=dle.pyc')
    f.write('%s\n' % 'ansible_ssh_private_key_file=/home/d/.ssh/gog')
if __name__ == "__main__":
    elk()
