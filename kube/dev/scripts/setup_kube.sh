#!/usr/bin/env bash
KUBEPATH="$(pwd)/$1"

# Setup cluster
kubectl config set-cluster local-kube-cluster --server=https://$2:443 --certificate-authority=$KUBEPATH/tmp/ssl/ca.pem
kubectl config set-credentials local-kube-admin --certificate-authority=$KUBEPATH/tmp/ssl/ca.pem --client-key=$KUBEPATH/tmp/ssl/admin-key.pem --client-certificate=$KUBEPATH/tmp/ssl/admin.pem
kubectl config set-context local-kube --cluster=local-kube-cluster --user=local-kube-admin
kubectl config use-context local-kube

