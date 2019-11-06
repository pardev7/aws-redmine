##Pre-requisite packages installation for the module for ubuntu machine
apt-get update
apt-get install ansible
sleep 60
apt-get install pip
sleep 60
pip install -r boto>=2.48.0    
pip install -r boto3>=1.7.42    
pip install -r botocore>=1.10.42