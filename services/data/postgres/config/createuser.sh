#!/bin/bash

LOG_FILE=/tmp/createuser.log

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
VAR_NEW_USER_NAME=${3:-KEYCLOAK_DB_USER}
VAR_NEW_DB_NAME=${4:-KEYCLOAK_DB_DATABASE}
VAR_NEW_USER_PASSWORD=${5:-KEYCLOAK_DB_PASSWORD}

echo "VAR_NEW_USER_NAME=${VAR_NEW_USER_NAME}." >>${LOG_FILE}
echo "VAR_NEW_DB_NAME=${VAR_NEW_DB_NAME}." >>${LOG_FILE}
echo "VAR_NEW_USER_PASSWORD=${VAR_NEW_USER_PASSWORD}." >>${LOG_FILE}

#source the env file
set -o allexport
source "${ENV_FILE}"
set +o allexport

# evaluate the variables
eval DB_USER='$'${VAR_DB_USER}
eval DB_NAME='$'${VAR_DB_NAME}
eval NEW_USER_NAME='$'${VAR_NEW_USER_NAME}
eval NEW_DB_NAME='$'${VAR_NEW_DB_NAME}
eval NEW_USER_PASSWORD='$'${VAR_NEW_USER_PASSWORD}

echo "DB_USER=${DB_USER}." >>${LOG_FILE}
echo "DB_NAME=${DB_NAME}." >>${LOG_FILE}
echo "NEW_USER_NAME=${NEW_USER_NAME}." >>${LOG_FILE}
echo "NEW_DB_NAME=${NEW_DB_NAME}." >>${LOG_FILE}

#compile new user script
# NEW_USER_SCRIPT=/docker-entrypoint-initdb.d/createuser-${NEW_USER_NAME}.sql
# echo "CREATE USER ${NEW_USER_NAME} WITH PASSWORD '${NEW_USER_PASSWORD}';" >${NEW_USER_SCRIPT}
# echo "CREATE DATABASE ${NEW_DB_NAME};" >>${NEW_USER_SCRIPT}
# echo "GRANT ALL PRIVILEGES ON DATABASE ${NEW_DB_NAME} TO ${NEW_USER_NAME};" >>${NEW_USER_SCRIPT}

PSQL_COMMAND="CREATE USER ${NEW_USER_NAME} WITH ENCRYPTED PASSWORD '${NEW_USER_PASSWORD}';"
OUTPUT=$(psql -v ON_ERROR_STOP=1 -c "$PSQL_COMMAND")

echo "PSQL output ${OUTPUT}." >>${LOG_FILE}

PSQL_COMMAND="CREATE DATABASE ${NEW_DB_NAME};"
OUTPUT=$(psql -v ON_ERROR_STOP=1 -c "$PSQL_COMMAND")

echo "PSQL output ${OUTPUT}." >>${LOG_FILE}

PSQL_COMMAND="GRANT ALL PRIVILEGES ON DATABASE ${NEW_DB_NAME} TO ${NEW_USER_NAME};"
OUTPUT=$(psql -v ON_ERROR_STOP=1 -c "$PSQL_COMMAND")
echo "PSQL output ${OUTPUT}." >>${LOG_FILE}

#run command
# OUTPUT=$(psql -v ON_ERROR_STOP=1 -c "$PSQL_COMMAND")

echo "PSQL output ${OUTPUT}." >>${LOG_FILE}

