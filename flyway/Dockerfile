FROM postgres:16-alpine3.20

# Install Flyway CLI
RUN apk add --no-cache wget tar bash && \
    wget -qO- https://download.red-gate.com/maven/release/com/redgate/flyway/flyway-commandline/11.3.0/flyway-commandline-11.3.0-linux-x64.tar.gz | tar xvz && \
    ln -s /flyway-11.3.0/flyway /usr/local/bin/flyway && \
    chmod +x /flyway-11.3.0/flyway /usr/local/bin/flyway
    
# Build arguments with default values
ARG POSTGRES_DB=bravadb_catalog
ARG POSTGRES_USER=user
ARG POSTGRES_PASSWORD=password

# Set environment variables
ENV POSTGRES_DB=${POSTGRES_DB} \
    POSTGRES_USER=${POSTGRES_USER} \
    POSTGRES_PASSWORD=${POSTGRES_PASSWORD}

# Copy SQL migration files
COPY src/main/resources/db/migration /flyway/sql

# Create init-db script
COPY <<EOF /docker-entrypoint-initdb.d/init-db.sh
#!/bin/bash
set -e

until pg_isready -q -U ${POSTGRES_USER}
do
    echo "Waiting for PostgreSQL to start..."
    sleep 1
done

echo "PostgreSQL started, running migrations..."
flyway \
    -url=jdbc:postgresql:///${POSTGRES_DB} \
    -user=${POSTGRES_USER} \
    -password=${POSTGRES_PASSWORD} \
    -locations=filesystem:/flyway/sql \
    migrate
EOF

RUN chmod +x /docker-entrypoint-initdb.d/init-db.sh

EXPOSE 5432