#!/bin/bash

echo "========== Step1: Uninstall old versions🔗 =========="
sudo apt-get remove docker docker-engine docker.io containerd runc -y
sleep 5
echo ""
echo ""

echo "========== Step2: Set up the repository =========="
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release wget

sleep 5
echo ""
echo ""

echo "========== Adding Docker’s official GPG key: =========="
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

sleep 5
echo ""
echo ""

echo "========== Setting up the repository: =========="
        echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sleep 5
echo ""
echo ""

echo "========== Step3: Installing Docker Engine =========="
        sudo apt-get update

sleep 5
echo ""
echo ""

        sudo apt-get install docker-ce docker-ce-cli containerd.io -y
echo "========== Starting and Enabling the Docker service =========="
        systemctl start docker
        systemctl enable docker

sleep 5
echo ""
echo ""



