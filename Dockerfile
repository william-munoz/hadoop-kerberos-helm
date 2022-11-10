ARG BUILDER_IMAGE_NAME=debian
ARG BUILDER_IMAGE_TAG=stretch-20220125-slim

ARG BASE_IMAGE_NAME=debian
ARG BASE_IMAGE_TAG=stretch-20220125-slim

ARG HADOOP_VERSION=3.3.1

FROM ${BUILDER_IMAGE_NAME}:${BUILDER_IMAGE_TAG} as builder
ARG HADOOP_VERSION
ARG HADOOP_DOWNLOAD_URL="https://www.apache.org/dyn/closer.cgi?action=download&filename=hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz"
ARG HADOOP_BACKUP_DOWNLOAD_URL="https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz"
ARG HADOOP_APPLY_PATCHES=false
COPY ./files/ /
RUN cd / && chmod u+x build-hadoop.sh && /build-hadoop.sh

FROM centos:7
ARG HADOOP_VERSION

RUN yum -y install krb5-server krb5-workstation \
    java-1.8.0-openjdk-headless \
    apache-commons-daemon-jsvc \
    net-tools \
    telnet telnet-server \
    which

RUN sed -i -e 's/#//' -e 's/default_ccache_name/# default_ccache_name/' /etc/krb5.conf

RUN useradd -u 1098 hdfs

COPY --from=builder --chown=root:root /hadoop-${HADOOP_VERSION} /hadoop

RUN mkdir -p -m 755 /var/log/hadoop \
	&& chown ${USER}:${GROUP} /var/log/hadoop \
    && chown -R -L hdfs /hadoop

COPY core-site.xml /hadoop/etc/hadoop/
COPY hdfs-site.xml /hadoop/etc/hadoop/
COPY ssl-server.xml /hadoop/etc/hadoop/
COPY yarn-site.xml /hadoop/etc/hadoop/
COPY krb5.conf /etc/

COPY start-namenode.sh /
COPY start-datanode.sh /
COPY populate-data.sh /
COPY start-kdc.sh /

COPY people.json /
COPY people.txt /

ENV JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk
ENV PATH=/hadoop/bin:$PATH
ENV HADOOP_CONF_DIR=/hadoop/etc/hadoop
