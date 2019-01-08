#!/bin/bash

# THIS SCRIPT CAN BE USED TO CLEAN UP THE SOCKSHOP DEPLOYMENT #
oc delete projects cicd dev staging production sockshop-registry
oc adm policy remove-scc-from-group hostpath system:authenticated
oc delete -f ../manifests/oc-scc-hostpath.yml
oc delete -f ../manifests/k8s-jenkins-rbac.yml
