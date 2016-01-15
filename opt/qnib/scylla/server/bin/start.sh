#!/bin/bash

source /etc/sysconfig/scylla-server


consul-template -once -template "/etc/consul-templates/scylladb/scylla.yaml.ctmpl:/etc/scylla/conf/scylla.yaml"

args="--log-to-syslog 1 --log-to-stdout 0 --default-log-level info $SCYLLA_ARGS"

if [ "$NETWORK_MODE" = "posix" ]; then
    args="$args --network-stack posix"
elif [ "$NETWORK_MODE" = "virtio" ]; then
    args="$args --network-stack native"
elif [ "$NETWORK_MODE" = "dpdk" ]; then
    args="$args --network-stack native --dpdk-pmd"
fi

export HOME=/var/lib/scylla
/usr/bin/scylla $args
