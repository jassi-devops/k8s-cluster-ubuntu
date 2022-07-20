# Install Kubernetes Cluster using kubeadm
```
Follow this documentation to set up a Kubernetes cluster on ubuntu 18.04/20.04/22.04.

This documentation guides you in setting up a cluster with one master node and multiple worker node.
```
## NOTE : Operating system should be same on all the nodes.

## Prerequisites: 

#### Hardware Requirement:    

|Role|OS|RAM|CPU|
|----|----|----|----|
|Master|ubuntu 18.04/20.04/22.04 |2G|2|
|Worker|ubuntu 18.04/20.04/22.04|1G|1|

#### Software Requirement:   
```
2 or more ubuntu 18.04/20.04/22.04 servers 
Access to a sudo or root privileged user account on each device 
The apt package manager. 
```
## Run On both master and worker
Perform all the commands as root user or sudo user.

### Clone the Repository on your Master and worker nodes
```
apt install git 
git clone https://github.com/jassi-devops/k8s-cluster-ubuntu.git
```
### Install Docker, Docker-engine, Kubeadm, kubectl
```
cd k8s-cluster-ubuntu/
chmod +x *
./setup_k8s_cluster.sh
```
## Run only on Master node
```
./k8s_master.sh
```
After completion of this script you will get the kubeadm token which you have to run on your worker nodes to communicate with master node.
