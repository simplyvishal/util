#!/bin/bash
# Dynatrace OneAgent Operator
git clone https://github.com/dynatrace/dynatrace-oneagent-operator.git
cp ./apply.sh ./dynatrace-oneagent-operator/deploy/apply.sh
cp ./cleanup.sh ./dynatrace-oneagent-operator/deploy/cleanup.sh

# Utility configuration
sudo ./hub-linux-amd64-2.6.0/install
sudo cp ./jq-linux64 /usr/sbin/jq

