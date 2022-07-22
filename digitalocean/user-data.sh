#!/bin/bash
curl -fsSL https://get.docker.com/ | sh
yum install -y wget unzip net-tools telnet rdate git 
rdate -s time.bora.net && clock -w
curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh
systemctl start docker && systemctl enable docker
cd /root/
curl -LO https://dl.k8s.io/release/v1.22.2/bin/linux/amd64/kubectl
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
echo "alias k='kubectl'" >> /root/.bashrc
systemctl disable --now firewalld
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=disabled/' /etc/selinux/config

