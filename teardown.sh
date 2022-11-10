#! /bin/bash

## Tear down
helm -n hdfs list

## Tear down datapopulator
helm -n hdfs delete datapopulator

## tear down datanode
helm -n hdfs delete datanode

## tear down namenode
helm -n hdfs delete namenode

## Tear down kdc
helm -n hdfs delete kdc

## Tear down pv
helm -n hdfs delete pv

## List Helm charts
helm -n hdfs list