#!/bin/bash
timedatectl set-timezone Asia/Seoul	
hostnamectl set-hostname eks-server	
cd /tmp								
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"	
unzip awscliv2.zip
./aws/install						
curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl
chmod +x ./kubectl					
mv ./kubectl /usr/local/bin			
echo "source <(kubectl completion bash)" >> /home/ec2-user/.bashrc
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
mv /tmp/eksctl /usr/local/bin	
