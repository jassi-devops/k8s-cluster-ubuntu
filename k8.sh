#!/bin/bash

until [ "$list" = "0" ]
do
read -r -p "Press [yY] if you want to list all the available kubernetes version else [nN] for Next step:  " list
case $list in
        [yY])
		curl -s https://packages.cloud.google.com/apt/dists/kubernetes-xenial/main/binary-amd64/Packages | grep Version | awk '{print $2}'
		echo "Enter the Kubernetes version that you want to install:"
                read K8SVERSION
		curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
		echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
		sudo apt-get update -q
		sudo apt-get install -y kubelet=$K8SVERSION kubectl=$K8SVERSION kubeadm=$K8SVERSION
		sudo apt-mark hold kubelet kubeadm kubectl
		exit 1;;
        [nN])
                echo "Enter the Kubernetes version that you want to install:"
                read K8SVERSION
		curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
		echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
		sudo apt-get update -q
		sudo apt-get install -y kubelet=$K8SVERSION kubectl=$K8SVERSION kubeadm=$K8SVERSION
		sudo apt-mark hold kubelet kubeadm kubectl
                exit 1;;
        *)
                echo "You have entered wrong option"
                ;;
esac
done



