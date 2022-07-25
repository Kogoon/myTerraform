## AWS

### eksctl

* Install
   * Required : `kubectl`
~~~
$ curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
$ sudo mv /tmp/eksctl /usr/local/bin
$ eksctl version
~~~


### AWS CLI

* Import SSH-KEY for ssh 

~~~
$ aws ec2 import-key-pair --key-name "<key_name>" --public-key-material file://<id_rsa.pub path>
~~~


* Create Cluster & Worker Nodes 
`CloudFormation`
~~~
$ aws create cluster --name <cluster_name> --version <version> --region <region> --node-group-name <node_group_name> --node-type t2.micro --nodes ? --nodes-min ? --nodes-max ? --node-volume-size 10 --ssh-access --ssh-public-key <key_name> --managed
~~~

   * `--managed` : Create EKS-managed nodegroup (default true)
   * `--fargate` : Create a Fargate profile scheduling pods in the default and kube-system namespaces onto Fargate



