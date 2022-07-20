#!/bin/bash

echo -e "Press the number to install Network overly that you want to setup on K8s cluster \n1. Flannel\n2. Calico"
read network

if [ $network = 1 ]
then
        sudo kubeadm init --pod-network-cidr=10.244.0.0/16 > kubeadm.log
        sleep 10
        echo "creating necessary directory and permissions"
        mkdir -p $HOME/.kube
        sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
        sudo chown $(id -u):$(id -g) $HOME/.kube/config
        export KUBECONFIG=/etc/kubernetes/admin.conf
        echo -e "\n kubeadm installed successfully\n"
else
        echo "wrong input"
fi

client_token=$(cat kubeadm.log | tail -2)
echo ""
echo -e "\nYou can join any number of worker nodes by running the following on each as root: \n$client_token"


wget https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl apply -f kube-flannel.yml
sleep 30

kubectl get nodes

echo -e "\nYou can join any number of worker nodes by running the following on each as root: \n$client_token"
