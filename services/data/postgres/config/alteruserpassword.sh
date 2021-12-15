#!/bin/bash

LOG_FILE=/tmp/alteruserpassword.log

# quick fail if the file doesn't exist
if [ ! -f ${ENV_FILE} ]; then
    echo "File ${ENV_FILE} does not exists." >>${LOG_FILE}
    exit 1
else
  echo "File ${ENV_FILE} exists." >>${LOG_FILE}
fi

# read the varibles name from the command line
VAR_DB_USER=${1:-POSTGRES_DB_USER}
VAR_DB_NAME=${2:-POSTGRES_DB}
VAR_NEW_USER_PASSWORD=${3:-POSTGRES_DB_PASSWORD}

echo "VAR_DB_USER=${VAR_DB_USER}." >>${LOG_FILE}
echo "VAR_DB_NAME=${VAR_DB_NAME}." >>${LOG_FILE}
echo "VAR_NEW_USER_PASSWORD=${VAR_NEW_USER_PASSWORD}." >>${LOG_FILE}

#source the env file
set -o allexport
source "${ENV_FILE}"
set +o allexport

# evaluate the variables
eval DB_USER='$'${VAR_DB_USER}
eval DB_NAME='$'${VAR_DB_NAME}
eval NEW_USER_PASSWORD='$'${VAR_NEW_USER_PASSWORD}

echo "DB_USER=${DB_USER}." >>${LOG_FILE}
echo "DB_NAME=${DB_NAME}." >>${LOG_FILE}

#compile new user script
#NEW_USER_SCRIPT=/docker-entrypoint-initdb.d/alteruserpassword-${DB_USER}.sql
#echo "ALTER USER ${DB_USER} WITH PASSWORD '${NEW_USER_PASSWORD}';" >${NEW_USER_SCRIPT}
PSQL_COMMAND="ALTER USER ${DB_USER} WITH ENCRYPTED PASSWORD '${NEW_USER_PASSWORD}';"

#run command
OUTPUT=$(psql -v ON_ERROR_STOP=1 -c "$PSQL_COMMAND")

echo "PSQL output ${OUTPUT}." >>${LOG_FILE}

