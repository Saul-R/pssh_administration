#!/bin/bash
# GET CLUSTER VARIABLES:

function usage {
  echo "
  This is a Cloudera Manager backup script.

  Example use:
    $0

  Will try to backup the conf to the file:
    ${BACKUP_DIR}/${CONF_PREFIX}_${TIMESTAMP}

  In any case, if the conf is unchanged it won't create any new file. 

  "
}

source /etc/cluster-admin/cluster-admin-env.sh

DATE_FORMAT="%Y%m%d_%H%M%S"
API_EXPORT="api/v9/cm/deployment"
BACKUP_DIR="/etc/cm/backup"
CONF_PREFIX="cm_conf"
TIMESTAMP=`date +${DATE_FORMAT}`
BACKUP_TEMP_FILE=${BACKUP_DIR}"/.temp.json"
BACKUP_FILE=${BACKUP_DIR}"/${CONF_PREFIX}_${TIMESTAMP}.json"
LAST_CONF_FILE_NAME=`ls -t ${BACKUP_DIR} | grep ${CONF_PREFIX} | head -1`
LAST_CONF=${BACKUP_DIR}/${LAST_CONF_FILE_NAME}

usage

mkdir -p ${BACKUP_DIR}

# La chicha:
curl -u ${ADMIN_USER}:${ADMIN_PASS} http://${CM_HOST}:${CM_PORT}/${API_EXPORT} > ${BACKUP_TEMP_FILE}

if [[ -z ${LAST_CONF_FILE_NAME} ]]; then
  echo ""
  echo "Creating first conf_backup on $BACKUP_FILE"
  mv ${BACKUP_TEMP_FILE} ${BACKUP_FILE}
  echo "DONE"
else
  DIFF=`diff ${BACKUP_TEMP_FILE} ${LAST_CONF}| grep -v "timestamp" | wc -l`
  # The timestamp: field is always different we ignore that with the grep before and the -le 2 in the if
  if [[ ${DIFF} -le 2 ]]; then
    echo ""
    echo "Conf_file unchanged"
    rm ${BACKUP_TEMP_FILE}
  else
    echo "Creating new conf_backup on $BACKUP_FILE"
    mv ${BACKUP_TEMP_FILE} ${BACKUP_FILE}
    echo "DONE"
  fi
fi
