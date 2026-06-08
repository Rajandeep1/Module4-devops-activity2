#!/bin/bash
set -e

cd /vagrant
docker build -t express-greeting-app .
docker rm -f express-app 2>/dev/null || true
docker run -d -p 3000:3000 --name express-app express-greeting-app
docker ps
echo "App available at http://192.168.56.67:3000"
