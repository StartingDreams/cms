#!/usr/bin/env bash
KUBEPATH="$(pwd)/$1"

# Exit if kubectl context doesnt match the local-kube master
ISCLUSERSET=$(kubectl cluster-info | grep "https://$2:443")
if [ "$ISCLUSERSET" = "" ]
then
  echo "Failed to setup cluster!"
  echo "Exiting"
  exit 1
fi

# Start APP
kubectl create -f $KUBEPATH/../cluster
