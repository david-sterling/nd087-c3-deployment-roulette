#!/bin/bash

#kubectl delete svc green-svc
kubectl apply -f ../starter/apps/blue-green/green.yml
kubectl apply -f ../starter/apps/blue-green/green-svc.yml

#Wait for deployment

while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' "$(kubectl get svc green-svc -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')")" != "200" ]];
do
    echo "Waiting for changes to propagate"
    sleep 5
done
curl "$(kubectl get svc green-svc -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')"