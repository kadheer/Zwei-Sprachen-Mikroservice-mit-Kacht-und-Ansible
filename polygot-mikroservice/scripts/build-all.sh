#!/bin/bash
# Alle Docker-Images bauen
docker build -t polyglot/cpp-service ./cpp-service
docker build -t polyglot/python-service ./python-service
echo "Images erstellt."
