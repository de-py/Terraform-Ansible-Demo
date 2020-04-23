# Download vault binary
curl -o vault.zip https://releases.hashicorp.com/vault/1.4.0/vault_1.4.0_linux_amd64.zip

# Install Unzip and unzip vault
sudo yum install -y unzip
sudo yum install -y tmux
unzip vault.zip

# Move vault to /usr/local/bin
sudo mv vault /usr/local/bin

# Make this available to path. May not be needed?
PATH=${PATH}:/usr/local/bin


# Install auto complete commands
vault -autocomplete-install

#run dev in tmux with
#vault server -dev



