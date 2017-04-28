#!/bin/bash

function pscpsudo(){
  set -x
  ORIGIN_PATH=$1
  REMOTE_PATH=$2
  HOSTFILE=$3
  
  ORIGIN_FILE=`basename $ORIGIN_PATH`
  ORIGIN_DIR=`dirname $ORIGIN_PATH`
  REMOTE_FILE=`basename $REMOTE_PATH`
  REMOTE_DIR=`dirname $REMOTE_PATH`
  TIMESTAMP=`date +%s`
  TMP_PATH=/tmp/${TIMESTAMP}/${REMOTE_FILE}

  pssh -h ${HOSTFILE} "mkdir -p `dirname ${TMP_PATH}`"
  pscp -h ${HOSTFILE} ${ORIGIN_PATH} ${TMP_PATH}
  pssh -h ${HOSTFILE} -i "sudo mkdir -p ${REMOTE_DIR}"
  pssh -h ${HOSTFILE} -i "sudo mv ${TMP_PATH} ${REMOTE_PATH}"
  
}

ORIGIN_PATH=$1
HOSTFILE=$2

pscpsudo $ORIGIN_PATH $ORIGIN_PATH $HOSTFILE
