# Creating Root CA

# Steps pulled from https://pki-tutorial.readthedocs.io/en/latest/simple/index.html 
# Added steps to script and modified for this project


# Create Directories
mkdir -p ca/root-ca/private ca/root-ca/db crl certs
chmod 700 ca/root-ca/private

# Create database as they must exist before using openssl ca
cp /dev/null ca/root-ca/db/root-ca.db
cp /dev/null ca/root-ca/db/root-ca.db.attr
echo 01 > ca/root-ca/db/root-ca.crt.srl
echo 01 > ca/root-ca/db/root-ca.crl.srl

# Create CA request. Creating private key and a CSR. 
# Modify root-ca.conf folder if another is used.
# Will ask for passphrase, store securely
openssl req -new \
    -config root-ca.conf \
    -out ca/root-ca.csr \
    -keyout ca/root-ca/private/root-ca.key

# Create CA Certificate
# Creating self signed certificate from CSR
# Will ask for same passphrase use in steps above
openssl ca -selfsign \
    -config root-ca.conf \
    -in ca/root-ca.csr \
    -out ca/root-ca.crt \
    -extensions root_ca_ext



# Creating Singing CA

# Create Directories
mkdir -p ca/signing-ca/private ca/signing-ca/db crl certs
chmod 700 ca/signing-ca/private

# Create Database
cp /dev/null ca/signing-ca/db/signing-ca.db
cp /dev/null ca/signing-ca/db/signing-ca.db.attr
echo 01 > ca/signing-ca/db/signing-ca.crt.srl
echo 01 > ca/signing-ca/db/signing-ca.crl.srl

# Create CA request, to be signed by root-ca
# Will ask for password, store securely
openssl req -new \
    -config signing-ca.conf \
    -out ca/signing-ca.csr \
    -keyout ca/signing-ca/private/signing-ca.key

