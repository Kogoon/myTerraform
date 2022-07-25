## AWS

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



