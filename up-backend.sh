#! /bin/bash

ip a

cat /etc/hosts

docker-compose -f couchdb.yml \
               -f nats-streaming.yml \
               -f eventstore.yml \
               up --build "$1" 



