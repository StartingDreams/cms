#!/usr/bin/env bash
KUBEPATH="$(pwd)/$1"

# Setup cluster
kubectl config set-cluster local-kube-cluster --server=https://$2:443 --certificate-authority=$KUBEPATH/tmp/ssl/ca.pem
kubectl config set-credentials local-kube-admin --certificate-authority=$KUBEPATH/tmp/ssl/ca.pem --client-key=$KUBEPATH/tmp/ssl/admin-key.pem --client-certificate=$KUBEPATH/tmp/ssl/admin.pem
kubectl config set-context local-kube --cluster=local-kube-cluster --user=local-kube-admin
kubectl config use-context local-kube

# Exit if kubectl context doesnt match the local-kube master
ISCLUSERSET=$(kubectl cluster-info | grep "https://$2:443")
if [ "$ISCLUSERSET" = "" ]
then
  echo "Failed to setup cluster!"
  echo "Exiting"
  exit 1
fi

# Create SSL Certificate for the dev frontend
openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout $KUBEPATH/tmp/ssl/frontend.key.pem -out $KUBEPATH/tmp/ssl/frontend.cert.pem -subj "/C=US/ST=Testing/L=Test/O=development/CN=kube.localhost.com"

# Create secrets
kubectl create -f $KUBEPATH/tmp/env-cfg.yaml
kubectl create secret generic frontend.ssl --from-file=$KUBEPATH/tmp/ssl/frontend.key.pem --from-file=$KUBEPATH/tmp/ssl/frontend.cert.pem

# Setup load balancer
kubectl label node $3 role=loadbalancer
kubectl create -f $KUBEPATH/loadbalancer.yaml

# Create APP
kubectl create -f $KUBEPATH/../cluster
