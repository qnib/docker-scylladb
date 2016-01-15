## QNIBTerminal image
FROM qnib/terminal:cos7

ENV SCYLLA_CLUSTER_NAME=qnib \
    SCYLLA_DATA_FILE_DIRECTORY=/data/scylla/data/ \
    SCYLLA_COMMITLOG_DIRECTORY=/data/scylla/log/ \
    SCYLLA_NUM_TOKENS=256 \
    SCYLLA_NATIVE_TRANSPORT_PORT=9042
RUN wget -O /etc/yum.repos.d/scylla.repo https://s3.amazonaws.com/downloads.scylladb.com/rpm/centos/scylla.repo && \
    yum install -y epel-release && \
    yum install -y scylla-server scylla-jmx scylla-tools && \
    mkdir -p /etc/scylla/conf/
ADD etc/sysconfig/scylla-server /etc/sysconfig/
ADD etc/consul-templates/scylladb/scylla.yaml.ctmpl /etc/consul-templates/scylladb/
ADD opt/qnib/scylla/server/bin/start.sh /opt/qnib/scylla/server/bin/
ADD opt/qnib/scylla/jmx/bin/start.sh /opt/qnib/scylla/jmx/bin/
ADD etc/supervisord.d/scylla-server.ini \
    etc/supervisord.d/scylla-jmx.ini \
    /etc/supervisord.d/
