#!/bin/sh

source k8s-setenv.sh

# create namespace
# Issue #1: currently doesn't work because pulling images from private registry fails.
#kubectl create namespace $KUBE_NAMESPACE
# set the namespace for all following kubectl commands
#kubectl config set-context $(kubectl config current-context) --namespace=$KUBE_NAMESPACE

# Build Docker image to Bluemix container registry
docker build -t $REGISTRY/$REGISTRY_NAMESPACE/$IMAGE_NAME:1 .
docker push $REGISTRY/$REGISTRY_NAMESPACE/$IMAGE_NAME:1
