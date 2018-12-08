#!/bin/bash
# Dynatrace OneAgent Operator
git clone https://github.com/dynatrace/dynatrace-oneagent-operator.git
cp ./util/apply.sh ./dynatrace-oneagent-operator/deploy/apply.sh
cp ./util/apply.sh ./dynatrace-oneagent-operator/deploy/cleanup.sh

# Utility configuration
sudo ./util/hub-linux-amd64-2.6.0/install
sudo cp ./util/jq-linux64 /usr/sbin/jq

