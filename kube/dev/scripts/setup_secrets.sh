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

# Create SSL Certificate for the dev frontend
openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout $KUBEPATH/tmp/ssl/frontend.key.pem -out $KUBEPATH/tmp/ssl/frontend.cert.pem -subj "/C=US/ST=Testing/L=Test/O=development/CN=kube.localhost.com"

# Create secrets
kubectl create -f $KUBEPATH/tmp/env-cfg.yaml
kubectl create secret generic frontend.ssl --from-file=$KUBEPATH/tmp/ssl/frontend.key.pem --from-file=$KUBEPATH/tmp/ssl/frontend.cert.pem

