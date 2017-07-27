#!/bin/sh

source k8s-setenv.sh

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
kubectl create -f k8s-car-dashboard.yml

# Echo description
kubectl describe service car-dashboard
bx cs workers car-dashboard
