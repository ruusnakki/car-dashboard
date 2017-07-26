#!/bin/sh

APP_NAME=car-dashboard

CLUSTER_NAME=$APP_NAME
CLUSTER_LOCATION=syd01
CLUSTER_WORKERS=2
CLUSTER_MC_TYPE=u1c.2x4
CLUSTER_HARDWARE=shared

VLAN_PRIV=priv01
VLAN_PUB=pub01

#KUBE_NAMESPACE=$APP_NAME
KUBE_NAMESPACE=default

REGISTRY=registry.au-syd.bluemix.net
REGISTRY_NAMESPACE=iwinoto_gmail_funfactory
IMAGE_NAME=$APP_NAME

# create namespace
#kubectl create namespace $KUBE_NAMESPACE
# set the namespace for all following kubectl commands
#kubectl config set-context $(kubectl config current-context) --namespace=$KUBE_NAMESPACE

# Build Docker image to Bluemix container registry
docker build -t $REGISTRY/$REGISTRY_NAMESPACE/$IMAGE_NAME:1 .
docker push $REGISTRY/$REGISTRY_NAMESPACE/$IMAGE_NAME:1

# Create services
# conversation
cf create-service conversation free my-conversation-service
# speech-to-text
cf create-service speech_to_text standard speech-to-text-service
# text-to-speech
cf create-service text_to_speech standard text-to-speech-service

# Bind services to the cluster
bx cs cluster-service-bind $CLUSTER_NAME $KUBE_NAMESPACE my-conversation-service
bx cs cluster-service-bind $CLUSTER_NAME $KUBE_NAMESPACE speech-to-text-service
bx cs cluster-service-bind $CLUSTER_NAME $KUBE_NAMESPACE text-to-speech-service

# Create the service
kubectl create -f car-dashboard-k8s.yml

# Echo description
kubectl describe service car-dashboard
bx cs workers car-dashboard
