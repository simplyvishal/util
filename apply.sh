#!/bin/bash
# The following script is to simplify the deployment of the Dynatrace OneAgent operator
# 3 variables are required and can be exported as environment variables:
# - apiToken    (example: /> export DTAPI="apiToken=1234567890abcdefghijlkmn")
# - paasToken   (example: /> export DTPAAS="passToken=1234567890abcdefghijklmn")
# - ENVIRONMENTID (example: /> export TENANTURL="abc12345.dynatrace.live.com"
#                --for Managed-- /> export TENANTURL="host_url/e/environmentid")

if [ -z "$1" ]; then
  echo "Usage: Arg 1 needs to be a valid apiToken entry [apiToken=...]"
  echo 'ex: ./apply.sh $DTAPI $DTPASS $DTENV'
  exit 1
fi

if [ -z "$2" ]; then
  echo "Usage: Arg 2 needs to be a valid paasToken entry [paasToken=...]"
  echo 'ex: ./apply.sh $DTAPI $DTPASS $DTENV'
  exit 1
fi

if [ -z "$3" ]; then
  echo "Usage: Environment ID is required to configure the OneAgent Operator"
  echo "example: /> export DTENV='abc12345'"
  echo "            --for Managed-- /> export DTENV='host_url/e/environmentid' "
  echo 'ex: ./apply.sh $DTAPI $DTPASS $DTENV'
  exit 1
fi

sed -i 's/ENVIRONMENTID/'"$3"'/' cr.yaml
oc create -f https://raw.githubusercontent.com/Dynatrace/dynatrace-oneagent-operator/master/deploy/openshift.yaml
oc -n dynatrace create secret generic oneagent --from-literal="$1" --from-literal="$2"
oc create -f ./cr.yaml
