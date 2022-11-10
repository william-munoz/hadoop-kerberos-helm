#! /bin/bash

## Current State
helm -n hdfs list

## List pods
kubectl get pods -n hdfs

## List services
kubectl get services -n hdfs

## List deployments
kubectl get deployments -n hdfs
