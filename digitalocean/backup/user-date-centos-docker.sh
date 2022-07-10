#!/bin/bash
curl -fsSL https://get.docker.com/ | sh
yum install -y wget unzip net-tools telnet rdate
rdate -s time.bora.net && clock -w
curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh
systemctl start docker && systemctl enable docker
