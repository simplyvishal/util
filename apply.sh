#!/bin/bash
# The following script is to simplify the deployment of the Dynatrace OneAgent operator
# 3 variables are required and can be exported as environment variables:
# - apiToken    (example: /> export DTAPI="apiToken=1234567890abcdefghijlkmn")
# - paasToken   (example: /> export DTPAAS="passToken=1234567890abcdefghijklmn")
# - ENVIRONMENTID (example: /> export TENANTURL="abc12345.dynatrace.live.com"
#                --for Managed-- /> export TENANTURL="host_url/e/environmentid")

if [ -z "$DTENV" ]; then
  echo
  echo "Usage: You must export DTENV=<Tenant Environment ID>"
  echo "example - export DTENV=abc12345 <-- for SaaS"
  echo "        - export DTENV=<url>/e/<envionmentid> <-- for managed"
  echo 
  exit 1
fi

if [ -z "$DTAPI" ]; then
  echo
  echo "Usage: you must export DTAPI=<Environment API Token>"
  echo 
  exit 1
fi

if [ -z "$DTPAAS" ]; then
  echo
  echo "Usage: you must export DTPAAS=<Environment PAAS Token>"
  echo 
  exit 1
fi

sed -i 's/ENVIRONMENTID/'"$DTENV"'/' cr.yaml
oc create -f https://raw.githubusercontent.com/Dynatrace/dynatrace-oneagent-operator/master/deploy/openshift.yaml
oc -n dynatrace create secret generic oneagent --from-literal="apiToken=$DTAPI" --from-literal="paasToken=$DTPAAS"
oc create -f ./cr.yaml
