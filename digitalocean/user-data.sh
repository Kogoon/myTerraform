#!/bin/bash
yum install -y httpd
systemctl enable --now httpd
export PUBLIC_IP=$(curl -s http://169.254.169.254/metadata/v1/interfaces/private/0/ipv4/address)
echo IP Address: $PUBLIC_IP > /var/www/html/index.html
