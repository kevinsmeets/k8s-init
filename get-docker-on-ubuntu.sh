#!/bin/bash

echo Install curl...
sudo apt-get install curl -y

echo Get docker script...
curl -fsSL https://get.docker.com -o get-docker.sh

echo Install docker...
sudo sh ./get-docker.sh

echo Adding current user to docker group...
sudo usermod -aG docker "$USER"

echo Make sure docker socket is useable for everyone...
sudo chmod 666 /var/run/docker.sock
ls -l /var/run/docker.sock

echo Running docker --version
docker --version

echo Cleanup...
rm get-docker.sh

echo Install bash completion for docker...
sudo apt-get install bash-completion -y
sudo curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh

echo Done!
