#! /bin/bash

docker-compose -f couchdb.yml \
               -f nats-streaming.yml \
               -f eventstore.yml \
               down || true
