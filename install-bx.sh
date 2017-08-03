#!/bin/bash
DOCKER_VER=17.06.0
# Install Docker
# ref: https://docs.docker.com/engine/installation/linux/docker-ce/binaries/
wget --output-document=tmp/docker/docker-$DOCKER_VER-ce.tgz https://download.docker.com/mac/static/stable/x86_64/docker-$DOCKER_VER-ce.tgz
tar -xzf tmp/docker/docker-$DOCKER_VER-ce.tgz
export PATH=$PATH:docker

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
bx plugin install container-service -r Bluemix -f

# Install container registry plugin
echo "Install the Bluemix container-registry plugin"
bx plugin install container-registry -r Bluemix -f

echo "Install kubectl"
wget --quiet --output-document=/tmp/Bluemix_CLI/bin/kubectl  https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x /tmp/Bluemix_CLI/bin/kubectl

if [ -n "$DEBUG" ]; then
  bx --version
  bx plugin list
fi
