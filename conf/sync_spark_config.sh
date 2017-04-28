#!/bin/bash

export SPARK_VERSION_HOME="/opt/spark/current"
export PROJECT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export HOSTS_FILE=$PROJECT_ROOT/spark-hosts
export DEFAULT_CONF=$PROJECT_ROOT/spark_centralized_files


if [ "$#" -eq 1 ]; then
  FILE_LIST=$1
  if [[ ! -f $FILE_LIST ]]; then
     echo "ERROR: file $FILE_LIST does not exists"
     exit 1     
  fi
else
  FILE_LIST=$DEFAULT_CONF
fi

for fichero in `envsubst < $FILE_LIST`; do 
  TMP_PATH="/tmp"$fichero
  BCKP_FILE="`dirname $fichero`/bckp/`basename $fichero`"-"`date +%Y%m%d`"."bckp"
  pssh -i -h $HOSTS_FILE "mkdir -p `dirname $TMP_PATH`; sudo mkdir -p `dirname $BCKP_FILE`"
  pscp -h $HOSTS_FILE $fichero `dirname $TMP_PATH`"/"
  pssh -i -h $HOSTS_FILE "sudo cp $fichero $BCKP_FILE; sudo mv $TMP_PATH $fichero"
done

echo "=== END ==="
