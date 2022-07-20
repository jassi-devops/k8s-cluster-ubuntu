#!/bin/bash
 sudo kubeadm init --pod-network-cidr=10.244.0.0/16
echo -e "Press the number to install Network overly that you want to setup on K8s cluster \n1. Flannel\n2. Calico"
read network

if [ $network = 1 ]
then
	sudo kubeadm init --pod-network-cidr=10.244.0.0/16 
	sleep 10

	mkdir -p $HOME/.kube
	sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
	sudo chown $(id -u):$(id -g) $HOME/.kube/config
	export KUBECONFIG=/etc/kubernetes/admin.conf
else
	echo "wrong input"
fi


