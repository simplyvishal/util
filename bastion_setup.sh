#!/bin/bash
# Dynatrace OneAgent Operator
git clone https://github.com/dynatrace/dynatrace-oneagent-operator.git
mv ./apply.sh ./dynatrace-oneagent-operator/deploy/apply.sh
mv ./cleanup.sh ./dynatrace-oneagent-operator/deploy/cleanup.sh

# Utility configuration
sudo ./hub-linux-amd64-2.6.0/install
sudo mv ./jq-linux64 /usr/sbin/jq

# bring local the provisioning scripts
git clone https://github.com/dt-seattle-acm-setup/provision-acm-openshift.git
mv ./creds.sav ./provision-acm-openshift/scripts/creds.json
mv ./cleanJenkins.sh ./provision-acm-openshift/scripts/cleanJenkins.sh

# log into the OpenShift cluster
oc login https://master1:443

# make bastion_setup.sh non-executable once completed
chmod 666 bastion_setup.sh
