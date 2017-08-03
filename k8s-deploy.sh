#!/bin/sh

source k8s-setenv.sh

echo -------
echo bx target
bx target
echo -------
echo bx login
bx login -a "$CF_API" --apikey "$BMX_APIKEY" -o "$CF_ORG" -s "$CF_SPACE"
echo -------
echo bx target
bx target
echo -------

echo Create services
# conversation
cf create-service conversation free my-conversation-service
# speech-to-text
cf create-service speech_to_text standard speech-to-text-service
# text-to-speech
cf create-service text_to_speech standard text-to-speech-service

echo Bind services to the cluster
bx cs cluster-service-bind $CLUSTER_NAME $KUBE_NAMESPACE my-conversation-service
bx cs cluster-service-bind $CLUSTER_NAME $KUBE_NAMESPACE speech-to-text-service
bx cs cluster-service-bind $CLUSTER_NAME $KUBE_NAMESPACE text-to-speech-service

echo Deploy the service to kubernetes
kubectl create -f k8s-car-dashboard.yml

# Echo description
kubectl describe service car-dashboard
bx cs workers $CLUSTER_NAME

# Create Ingress
#kubectl apply -f k8s-car-dashboard-ingress.yml
