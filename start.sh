
SERVICES=$(tr '\n' ' -f ' < start-services.conf | sed 's/,$/\n/')

docker-compose --env-file .env -f docker-compose.yml -f ${SERVICES} up
