#!/bin/bash
#Ref https://github.com/zilexa/Homeserver

echo "____________________________________________________"
echo "Install Docker " 
echo "____________________________________________________"
export DEBIAN_FRONTEND=noninteractive
sudo apt update

#Next, install a few prerequisite packages which let apt use packages over HTTPS
sudo apt -y install apt-transport-https ca-certificates curl software-properties-common

#Then add the GPG key for the official Docker repository to your system
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

#Add the Docker repository to APT sources:
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

#Update your existing list of packages again for the addition to be recognized
sudo apt update

#Finally, install Docker:
sudo apt -y install docker-ce docker-ce-cli containerd.io

#Install docker compose, ToDo: find a way to get the latests version
sudo curl -L "https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

#Check installed versions
docker version
docker-compose version

echo "-----------------"
echo "Configure Docker "
echo "-----------------"
# Make docker-compose file an executable file and add the current user to the docker container
sudo chmod +x /usr/local/bin/docker-compose

#If you want to avoid typing sudo whenever you run the docker command, add your username to the docker group
sudo usermod -aG docker ${USER}

#make docker folder
sudo mkdir -p $HOME/docker
sudo chmod -R 755 $HOME/docker

#create docker network
docker network create

echo "-----------------"
echo "Configure Fish "
echo "-----------------"
#We are going to install `fish` which is and user-friendly command line.
sudo apt -y install fish
#We are going to make it the the default shell.
usermod --shell /bin/fish ${USER}


