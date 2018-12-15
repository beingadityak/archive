#!/bin/bash

echo "Downloading Splunk v7.0.2 (Minty) in the VM..."
wget https://download.splunk.com/products/splunk/releases/7.0.2/linux/splunk/splunk-7.0.2-03bbabbd5c0f-linux-2.6-amd64.deb > installation.log
echo "Installing Splunk v7.0.2 (Minty) in the VM..."
dpkg -i splunk-7.0.2-03bbabbd5c0f-linux-2.6-amd64.deb
echo "Installation steps..."
sudo chown -R splunk:splunk /opt/splunk
/opt/splunk/bin/splunk start --accept-license
rm -rf splunk-7.0.2-03bbabbd5c0f-linux-2.6-amd64.deb
rm -rf installation.log
echo "Your Splunk installation is now ready...!"