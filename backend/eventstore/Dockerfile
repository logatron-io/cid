# FROM eventstore/eventstore:20.10.4-buster-slim
#FROM eventstore/eventstore:21.2.0-bionic
FROM eventstore/eventstore:5.0.11-bionic
# COPY eventstore.conf /etc/eventstore/eventstore.conf
#VOLUME /var/lib/eventstore /var/log/eventstore

EXPOSE 1112/tcp 1113/tcp 2112/tcp 2113/tcp

HEALTHCHECK --interval=5s --timeout=5s --retries=24 \
    CMD curl --fail --insecure https://localhost:2113/health/live || curl --fail http://localhost:2113/health/live || exit 1

# ENTRYPOINT ["/opt/eventstore/EventStore.ClusterNode"]