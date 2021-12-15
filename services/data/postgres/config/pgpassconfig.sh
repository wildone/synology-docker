set -o allexport; source /pgadmin4/env; set +o allexport;
mkdir -m 700 /var/lib/pgadmin/storage/pgadmin_localhost.com;
chown -R pgadmin:pgadmin /var/lib/pgadmin/storage/pgadmin_localhost.com;
#cp -prv /pgadmin4/pgpass /var/lib/pgadmin/storage/pgadmin_localhost.com/;
echo ${POSTGRES_HOST}:${POSTGRES_PORT}:${POSTGRES_DB}:${POSTGRES_DB_USER}:${POSTGRES_DB_PASSWORD}>/var/lib/pgadmin/storage/pgadmin_localhost.com/pgpass
chmod 600 /var/lib/pgadmin/storage/pgadmin_localhost.com/pgpass;
