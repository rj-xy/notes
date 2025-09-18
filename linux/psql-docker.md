# Docker/PSQL

```
docker run --name postgres-test --expose 5432 -e POSTGRES_PASSWORD=mysecretpassword -d postgres
docker run -dt --name psql-client alpine /bin/sh -c "apk update && apk add postgresql-client bind-tools && sleep 1h"

docker exec psql-client psql --help

# Create DB
docker exec \
    --env PGHOST=172.27.0.3 \
    --env PGUSER=postgres \
    --env PGPASSWORD=some-password \

postgres-client psql --command "CREATE DATABASE TEST"

# Shell
docker exec \
    --env PGHOST=postgres-db \
    --env PGUSER=postgres \
    --env PGPASSWORD=some-password \
    -it postgres-client /bin/sh

docker exec -it did /bin/sh


# psql -> \l

docker run -it docker /bin/sh
```

Delete all DBs
```
apk update && apk add postgresql-client bind-tools
psql --command "select 'drop database \"'||datname||'\";' from pg_database where database_name LIKE 'TEST_%';" | grep drop > drop_db.sh
psql -f drop_db.sh
psql --command "\l"
```

docker-compose.yml
```
# docker-compose up -d
version: '3.7'

services:
    postgres-db:
        container_name: postgres-db
        image: postgres
        ports:
            - 5432:5432
        environment:
            POSTGRES_PASSWORD: some-password
            POSTGRES_USER: postgres
    		options: >-
				  --health-cmd pg_isready
				  --health-interval 10s
				  --health-timeout 5s
				  --health-retries 5

    postgres-client:
        container_name: postgres-client
        image: alpine
        stdin_open: true
        tty: true
        environment:
            PGHOST: postgres-db
            PGUSER: postgres
            PGPASSWORD: some-password
        command: /bin/sh -c "apk update && apk add postgresql-client bind-tools && sleep 1h"

    docker-in-docker:
        container_name: did
        image: alpine
        stdin_open: true
        tty: true
        environment:
            PGHOST: postgres-db
            PGUSER: postgres
            PGPASSWORD: some-password
        command: /bin/sh -c "sleep 1h"
```
