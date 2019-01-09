#!/bin/bash

# log into the OpenShift cluster
echo ""
echo "Please log into your OpenShift cluster"
oc login https://master1:443

# Dynatrace OneAgent Operator
if [ $(oc get namespace | grep dynatrace | wc -l) == 0 ]; then
 git clone https://github.com/dynatrace/dynatrace-oneagent-operator.git ~/dynatrace-oneagent-operator
 cp ./apply.sh ~/dynatrace-oneagent-operator/deploy/apply.sh
 cp ./cleanup.sh ~/dynatrace-oneagent-operator/deploy/cleanup.sh
fi

# Utility configuration
sudo ~/util/hub-linux-amd64-2.6.0/install
sudo cp ~/util/jq-linux64 /usr/sbin/jq
echo ""
read -p "Please enter your Github Username: " GITU
read -p "Please enter your Github Organization: " GITO
echo ""
echo "Github Username: " $GITU
echo "Github Organization: " $GITO
read -p "Is this all correct?" -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]
then
# bring local the provisioning scripts
  git config --global credential.helper cache
  git config --global credential.https://github.com.$GITU $GITO
  git clone https://$GITU@github.com/dt-toronto-acm/provision-acm-openshift.git ~/provision-acm-openshift
  cd ~
    ~/provision-acm-openshift/scripts/forkGitHubRepositories.sh $GITO 
fi
cp ~/util/clean_Workshop.sh ~/provision-acm-openshift/scripts/clean_Workshop.sh

# make bastion_setup.sh non-executable once completed
chmod 666 ~/util/bastion_setup.sh
