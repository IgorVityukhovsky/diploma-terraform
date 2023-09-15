#!/bin/bash
sudo apt update  && \
sudo apt-get install git pip python3.9 build-essential libssl-dev libffi-dev python3.9-dev -y  && \
git clone https://github.com/kubernetes-sigs/kubespray.git  && \
cd kubespray  && \
cp -rfp inventory/sample inventory/mycluster  && \
wget https://bootstrap.pypa.io/get-pip.py  && \
sudo python3.9 get-pip.py  && \
sudo pip3.9 install -r requirements.txt  && \
declare -a IPS=(192.168.10.5 192.168.20.31 192.168.30.22)  && \
CONFIG_FILE=inventory/mycluster/hosts.yaml python3.9 contrib/inventory_builder/inventory.py ${IPS[@]}  && \
cat /home/igor/hosts.yaml > inventory/mycluster/hosts.yaml  && \
ansible-playbook -i inventory/mycluster/hosts.yaml cluster.yml -b -v  && \
mkdir -p $HOME/.kube  && \
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config  && \
sudo chown $(id -u):$(id -g) $HOME/.kube/config

