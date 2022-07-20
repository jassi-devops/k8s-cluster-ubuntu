#!/bin/bash

os=$(cat /etc/*release | grep ^NAME | egrep -i 'ubuntu|centos' | sed -e 's/=/ /g' |sed -e 's/"/ /g' | awk '{ print $2 }' | tr [:upper:] [:lower:])

echo "======== Operating Syster is "$os" ========" 
echo ""
echo ""

if [ $os == centos ] 
then
        echo "centos"
        
else [ $os == ubuntu ] 
	sh ./docker_installation.sh

	service=$(service docker status | grep -i running | awk '{ print $3 }' | wc -l)

	if [ $service == 1 ]
	then
		echo "========== Docker service is Running =========="
		sleep 5
		echo ""
		echo ""
		echo "========== Step4: Checking Installed Docker Version =========="
		docker --version
	else
		echo "Docker service is not running"
	fi
fi

sh ./k8.sh
