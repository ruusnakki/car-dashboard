#!/bin/sh

API_USERNAME=$1
API_KEY=$2

APP_NAME=car-dashboard

CLUSTER_NAME=$APP_NAME
CLUSTER_LOCATION=syd01
CLUSTER_WORKERS=2
CLUSTER_MC_TYPE=u1c.2x4
CLUSTER_HARDWARE=shared

VLAN_PRIV=priv01
VLAN_PUB=pub01

KUBE_NAMESPACE=$APP_NAME

REGISTRY=registry.au-syd.bluemix.net
REGISTRY_NAMESPACE=iwinoto_gmail_funfactory
IMAGE_NAME=$APP_NAME

# Set the credentials
bx cs credentials-set --infrastructure-username $API_USERNAME --infrastructure-api-key $API_KEY

# Create VLANs if they don't already exist
#bx sl vlan create --vlan-type private --datacenter syd01 --name $VLAN_PRIV
#bx sl vlan create --vlan-type public --datacenter syd01 --name $VLAN_PUB

# Create a standard cluster
#bx cs cluster-create \
#  --name $CLUSTER_NAME \
#  --location $CLUSTER_LOCATION \
#  --workers $CLUSTER_WORKERS \
#  --machine-type $CLUSTER_MC_TYPE \
#  --hardware $CLUSTER_HARDWARE \
#  --public-vlan $VLAN_PUB \
#  --private-vlan $VLAN_PRIV

# Create a lite (free) cluster
bx cs cluster-create --name $CLUSTER_NAME
