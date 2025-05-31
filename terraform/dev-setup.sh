#!/bin/bash
set -e
environment=$1
app_version=$2
# install httpd
yum install -y httpd
# start httpd
systemctl start httpd
# enable httpd
systemctl enable httpd  

#install ansible
yum install -y ansible

ansible -i "localhost" -m ping