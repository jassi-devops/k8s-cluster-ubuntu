#!/bin/bash

echo "========== Step1: update and upgrade the packages🔗 =========="
sudo apt update
sudo apt -y full-upgrade
sleep 5
echo -e ""

echo "========== Step2: disable swap space🔗 =========="
sudo sudo swapoff -a
sleep 5
echo -e ""


echo "========== Step3: Install kubelet kubectl kubeadm 🔗 =========="
until [ "$list" = "0" ]
do
read -r -p "Press [yY] if you want to select any specific kubernetes version and [nN] for the latest Version:  " list
case $list in
        [yY])
		curl -s https://packages.cloud.google.com/apt/dists/kubernetes-xenial/main/binary-amd64/Packages | grep Version | awk '{print $2}'
		read -r -p "Enter the Kubernetes version that you want to install example 1.22.0-00: " K8SVERSION
		
		echo -e "\n========== Installing kubelet kubectl kubeadm 🔗 =========="
		curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
		echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
		sudo apt-get update
		sudo apt-get install -y kubelet=$K8SVERSION kubectl=$K8SVERSION kubeadm=$K8SVERSION
		sudo apt-mark hold kubelet kubeadm kubectl
		echo "========== Installation done successfully 🔗 =========="
		sleep 5
		exit 1;;
        [nN])
                echo -e "\n========== Installing kubelet kubectl kubeadm 🔗 =========="
		sudo apt -y install curl apt-transport-https
		curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
		echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
		sudo apt-get update
		sudo apt-get install -y kubelet kubectl kubeadm
		sudo apt-mark hold kubelet kubeadm kubectl
		echo "========== Installation done successfully 🔗 =========="
		sleep 5
                exit 1;;
        *)
                echo "You have entered wrong option"
                ;;
esac
done

echo "========== Step4: Uninstall docker and containerd if Exist🔗 =========="
sudo apt-get remove docker docker-engine docker.io containerd runc -y
sleep 5
echo -e "\n\n"

echo -e "========== Step5: Installing Containerd ==========\n"

# Configure persistent loading of modules
sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

# Load at runtime
sudo modprobe overlay
sudo modprobe br_netfilter

# Ensure sysctl params are set
sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# Reload configs
sudo sysctl --system

# Install required packages
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates

# Add Docker repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install containerd
sudo apt update
sudo apt install -y containerd.io

# restart containerd
sudo systemctl restart containerd
sudo systemctl enable containerd
sudo systemctl enable kubelet



