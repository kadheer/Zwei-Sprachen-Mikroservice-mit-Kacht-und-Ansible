#!/bin/bash
# Skript zum Bauen und Pushen der Docker-Images in eine Registry
# Erwartet: Docker Hub Benutzername als Umgebungsvariable $DOCKER_USER

set -e

# Prüfen, ob Docker Benutzername gesetzt ist
if [ -z "$DOCKER_USER" ]; then
    echo "Fehler: Bitte setzen Sie die Umgebungsvariable DOCKER_USER"
    echo "Beispiel: export DOCKER_USER=ihrbenutzername"
    exit 1
fi

# C++-Service bauen
echo "Baue C++-Service Image..."
docker build -t cpp-service ./cpp-service

# Python-Service bauen
echo "Baue Python-Service Image..."
docker build -t python-service ./python-service

# Taggen für die Registry
echo "Tagge Images für Docker Hub..."
docker tag cpp-service $DOCKER_USER/polyglot-cpp:latest
docker tag python-service $DOCKER_USER/polyglot-python:latest

# Pushen
echo "Pushe Images zu Docker Hub..."
docker push $DOCKER_USER/polyglot-cpp:latest
docker push $DOCKER_USER/polyglot-python:latest

echo "Fertig! Images sind unter $DOCKER_USER/polyglot-cpp und $DOCKER_USER/polyglot-python verfügbar."
