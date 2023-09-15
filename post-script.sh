curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
helm repo add stable https://charts.helm.sh/stable
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install stable prometheus-community/kube-prometheus-stack
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.1/deploy/static/provider/baremetal/deploy.yaml
echo "sleep 110s"
sleep 110s
kubectl apply -f ingress.yml
echo "sleep 70s"
sleep 70s
kubectl patch svc ingress-nginx-controller -n ingress-nginx --type='json' -p='[{"op": "replace", "path": "/spec/ports/0/nodePort", "value": 30000}]'
kubectl get svc -n ingress-nginx

#UserName: admin
#Password: prom-operator

# sudo mkdir /pv && sudo mount /dev/vdb1 /pv && echo '/dev/vdb1 /pv ext4 defaults 0 0' | sudo tee -a /etc/fstab && lsblk

kubectl apply -f jen.yml
kubectl apply -f my-app-svc.yml
