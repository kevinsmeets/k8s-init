#!/bin/bash

echo Install curl...
sudo apt-get install curl

echo Get docker script...
curl -fsSL https://get.docker.com -o get-docker.sh

echo Install docker...
sudo sh ./get-docker.sh

echo Adding current user to docker group...
sudo usermod -aG docker $USER

echo Make sure docker socket is useable for everyone...
ls -l /var/run/docker.sock
sudo chmod 666 /var/run/docker.sock

echo Running docker --version
docker --version

