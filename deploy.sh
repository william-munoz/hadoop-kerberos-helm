#! /bin/bash

## Current State
helm -n hdfs list

## Deploy pv
helm -n hdfs install pv ./pv/

## Deploy kdc
helm -n hdfs install kdc ./kdc/

## Deploy namenode
helm -n hdfs install namenode ./namenode/

## Deploy datanode
helm -n hdfs install datanode ./datanode/

## Deploy datapopulator
helm -n hdfs install datapopulator ./datapopulator

## List Helm charts
helm -n hdfs list