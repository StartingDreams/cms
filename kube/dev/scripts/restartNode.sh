#!/usr/bin/env bash

echo "Deleting running node pods. The deployment will recreate them."
kubectl delete pods -l restartFlag=node