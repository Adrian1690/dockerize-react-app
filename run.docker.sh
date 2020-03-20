#!/usr/bin/env bash

# Build image

docker build -f Dockerfile-dev -t reactdocker:dev .

# Run image 
docker run \
    --rm \
    -v ${PWD}:/app \
    -v /app/node_modules \
    -p 3001:3000 \
    reactdocker:dev

# create docker machine and ge hot realoading
docker-machine create -d virtualbox reactmachine
docker-machine env reactmachine
eval $(docker-machine env reactmachine)

#then
docker build -t reactdocker:dev .
docker run -v ${PWD}:/app -v /app/node_modules -p 3001:3000 -e CHOKIDAR_USEPOLLING=true --rm reactdocker:dev


## Production
# Build production 

docker build  -t reactdocker:prod 

# Run production

docker run -it -p 80:80 --rm reactdocker:prod