# Digital Ocean

### Install doctl 

* download the most recent version of `doctl`
~~~
$ cd ~
$ wget https://github.com/digitalocean/doctl/releases/download/v1.77.0/doctl-1.77.0-linux-amd64.tar.gz
~~~

* extract the binary 
~~~
$ tar xf ~/doctl-1.77.0-linux-amd64.tar.gz
~~~

* move the `doctl` binary into path by running 
~~~
$ sudo mv ~/doctl /usr/local/bin
~~~


### Environment variable

* digital ocean variable format `TF_VAR_<variable_name>`
ex)
~~~
$ export TF_VAR_do_token=<token>
~~~

variables.tf
~~~
variable "do_token" {}
~~~

