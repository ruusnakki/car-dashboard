#!/bin/bash

# Install Docker
echo "### Install Docker"
# ref: https://docs.docker.com/engine/installation/linux/ubuntu/#/install-docker
apt-get update
apt-get install -y --no-install-recommends \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual \
    curl \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    unzip

curl -fsSL https://apt.dockerproject.org/gpg | apt-key add -

add-apt-repository \
       "deb https://apt.dockerproject.org/repo/ \
       ubuntu-$(lsb_release -cs) \
       main"

apt-get update

apt-get -y install docker-engine

#add user ubuntu to docker group
usermod -aG docker ubuntu


echo "Download Bluemix CLI"
wget --quiet --output-document=/tmp/Bluemix_CLI_amd64.tar.gz  http://public.dhe.ibm.com/cloud/bluemix/cli/bluemix-cli/latest/Bluemix_CLI_amd64.tar.gz
tar -xf /tmp/Bluemix_CLI_amd64.tar.gz --directory=/tmp

# Create bx alias
echo "#!/bin/sh" >/tmp/Bluemix_CLI/bin/bx
echo "/tmp/Bluemix_CLI/bin/bluemix \"\$@\" " >>/tmp/Bluemix_CLI/bin/bx
chmod +x /tmp/Bluemix_CLI/bin/*

export PATH="/tmp/Bluemix_CLI/bin:$PATH"

# Install Armada CS plugin
echo "Install the Bluemix container-service plugin"
bx plugin install container-service -r Bluemix

echo "Install kubectl"
wget --quiet --output-document=/tmp/Bluemix_CLI/bin/kubectl  https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x /tmp/Bluemix_CLI/bin/kubectl

if [ -n "$DEBUG" ]; then
  bx --version
  bx plugin list
fi
