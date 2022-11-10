#! /bin/bash

## Env Variables
HADOOP_VERSION=0.0.5
ACCOUNT=$(aws sts get-caller-identity --query Account --output text)
REGION=us-west-2
REPO_PREFIX="${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com/hdfs"

## Validate variables
echo $HADOOP_VERSION
echo $ACCOUNT
echo $REGION
echo $REPO_PREFIX

## Build the image
docker build -t hdfs:${HADOOP_VERSION} . \
    && docker image tag hdfs:${HADOOP_VERSION} ${REPO_PREFIX}:${HADOOP_VERSION} \
    && docker image push ${REPO_PREFIX}:${HADOOP_VERSION}

## List images in the repository
aws ecr list-images --repository-name hdfs --region us-west-2
