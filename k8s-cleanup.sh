#!/bin/sh

source k8s-setenv.sh

# Delete the namespace
#kubectl delete namespace $KUBE_NAMESPACE
# Reset the namespace to `default` for all following kubectl commands
#kubectl config set-context $(kubectl config current-context) --namespace=default

# If not using namespace, delete objects individually
kubectl delete ingress $APP_NAME-ingress
kubectl delete deployment $APP_NAME
kubectl delete service $APP_NAME
bx cs cluster-service-unbind $CLUSTER_NAME $KUBE_NAMESPACE my-conversation-service
bx cs cluster-service-unbind $CLUSTER_NAME $KUBE_NAMESPACE speech-to-text-service
bx cs cluster-service-unbind $CLUSTER_NAME $KUBE_NAMESPACE text-to-speech-service
kubectl delete secret binding-my-conversation-service
kubectl delete secret binding-speech-to-text-service
kubectl delete secret binding-text-to-speech-service
