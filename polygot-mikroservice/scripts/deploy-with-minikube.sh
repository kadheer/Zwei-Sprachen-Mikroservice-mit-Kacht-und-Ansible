#!/bin/bash
# Minikube starten, Images laden, Deployments anwenden
minikube start
eval $(minikube docker-env)
docker build -t polyglot/cpp-service ./cpp-service
docker build -t polyglot/python-service ./python-service
kubectl apply -f ./k8s/
echo "Warte auf Pods..."
kubectl wait --for=condition=ready pod -l app=python-service --timeout=60s
minikube service python-service --url
