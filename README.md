# Install Kubernetes Cluster with Flannel on Ubuntu

Follow this documentation to set up a Kubernetes cluster on ubuntu 18.04/20.04/22.04.

This documentation guides you in setting up a cluster with one master node and multiple worker node.

## NOTE : Operating system should be same on all the nodes.

## Prerequisites: 

#### Hardware Requirement:    

|Role|OS|RAM|CPU|
|----|----|----|----|
|Master|ubuntu 18.04/20.04/22.04 |2G|2|
|Worker|ubuntu 18.04/20.04/22.04|1G|1|

#### Software Requirement:   
```
1. Kubernetes Version < 1.20 
2. Two or more ubuntu 18.04/20.04/22.04 servers 
3. Access to a sudo or root privileged user account on each device 
4. The apt package manager. 
```
## Run On both master and worker
Perform all the commands as root user or sudo user.

#### Clone the Repository on your Master and worker nodes
```
apt install git 
git clone https://github.com/jassi-devops/k8s-cluster-ubuntu.git
```
#### Install Docker, Docker-engine, kubelet, Kubeadm, kubectl
```
cd k8s-cluster-ubuntu/
chmod +x *
./setup_k8s_cluster.sh
```
## Run only on Master node
```
./k8s_master.sh
```
After completion of this script you will get the kubeadm token which you have to run on your worker nodes to communicate with master node. Token should be like: 
```
kubeadm join 172.31.35.212:6443 --token yjkioo.jczj2y6a3qu6b7hu \
    --discovery-token-ca-cert-hash sha256:24dd1f107a014279025947dbf797ac5c44e1df6941377f987d5c6a2490e8fdea
```

## Run only on Workers node
```
Run the kubeadm join command on all workers node to connect with master node.
```

## Check whether your master and worker node is ready or not.
Run the command on master node to get the nodes status
```
kubectl get nodes
```
You will get the output as metioned below:
|NAME|STATUS|ROLES|AGE|VERSION|
|----|----|----|----|----|
|ip-172-31-35-211|Ready|master|10m|v1.19.0|
|ip-172-31-35-213|Ready|worker|10m|v1.19.0|

You should now have Kubernetes installed on Ubuntu.
