set -o allexport
source /pgadmin4/env
set +o allexport;

LOG_FILE="/tmp/pgpassconfig.log"
USER_FOLDER_NAME="${POSTGRES_DB_ADMIN_PGADMIN_DEFAULT_EMAIL//[@]/_}"
USER_FOLDER="/var/lib/pgadmin/storage/${USER_FOLDER_NAME}"
USER_PGPASS_FILE="${USER_FOLDER}/pgpass"
DATA_FODLER="/var/lib/pgadmin"

echo "Createting pgpass for user ${USER_FOLDER}" >>${LOG_FILE}

ls -l ${DATA_PATH_HOST} >>${LOG_FILE}

mkdir -m 700 -p ${USER_FOLDER}

echo "Folder created $(ls -latr ${USER_FOLDER})" >>${LOG_FILE}

chown -R pgadmin:pgadmin ${USER_FOLDER}
chown -R pgadmin:pgadmin ${DATA_FODLER}

touch ${USER_PGPASS_FILE}

echo "File created $(cd ${USER_FOLDER} && ls -latr )" >>${LOG_FILE}

# add users to pgpass file
echo ${POSTGRES_HOST}:${POSTGRES_PORT}:${POSTGRES_DB}:${POSTGRES_DB_USER}:${POSTGRES_DB_PASSWORD} >${USER_PGPASS_FILE}
echo ${POSTGRES_HOST}:${POSTGRES_PORT}:${KEYCLOAK_DB_DATABASE}:${KEYCLOAK_DB_USER}:${KEYCLOAK_DB_PASSWORD} >>${USER_PGPASS_FILE}

echo "File updated $(cd ${USER_FOLDER} && ls -latr )" >>${LOG_FILE}

echo ${POSTGRES_HOST}:${POSTGRES_PORT}:${POSTGRES_DB}:${POSTGRES_DB_USER}:${POSTGRES_DB_PASSWORD//?/x} >>${LOG_FILE}
echo ${POSTGRES_HOST}:${POSTGRES_PORT}:${KEYCLOAK_DB_DATABASE}:${KEYCLOAK_DB_USER}:${KEYCLOAK_DB_PASSWORD//?/x} >>${LOG_FILE}

chmod 600 ${USER_PGPASS_FILE}

echo "File chmod applied $(cd ${USER_FOLDER} && ls -latr )" >>${LOG_FILE}
