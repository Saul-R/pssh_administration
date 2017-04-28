#!/bin/bash

export CONF_ROOT="/etc/cluster-admin"

export ADMIN_USER="admin"
export ADMIN_PASS="ij^aKeM4l4RG"

export HIVE_USER_MYSQL="hive"
export HIVE_PASS_MYSQL="oDKigOvc4lEn"

export CM_HOST="cdh-master3"
export CM_PORT="7180"
export CDH_CLUSTER_NAME="Cluster 1"

export ATLAS_HOST="cdh-master3"
export FALCON_HOST="cdh-master3"
export NEO4J_HOST="nosql1"
#export MONGO_HOSTS="nosql1 nosql2 nosql3"
export MONGO_HOSTS="nosql1"
export MONGO_ENDPOINT="nosql1"
#export CASSANDRA_HOSTS="nosql1 nosql2 nosql3"
export CASSANDRA_HOSTS="nosql1"
export CASSANDRA_ENDPOINT="nosql1"
export CASSANDRA_PORT="9042"

export SPARK_HOSTFILE="${CONF_ROOT}/spark-hosts"
export ELASTICSEARCH_HOSTFILE="${CONF_ROOT}/elasticsearch-hosts"

source "${CONF_ROOT}/cluster-admin-env-open.sh"
