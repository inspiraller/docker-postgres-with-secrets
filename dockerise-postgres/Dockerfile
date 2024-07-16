FROM postgres:latest

# copy-data.sh
COPY ./postgresql_data ./temp

# Copy init.table.csv to /var/lib/postgresql/data/init.table.csv 
#   - Wait for postgres build to have created folder: /var/lib/postgresql/data 
#   - Then on docker-entrypoint-initdb.d/copy-data.sh
COPY ./scripts/copy-data.sh /docker-entrypoint-initdb.d/copy-data.sh
# cp /temp/data/init.table.csv -u /var/lib/postgresql/data/init.table.csv 


# Initialise database with a create table
COPY ./scripts/seed.sql /docker-entrypoint-initdb.d/seed.sql
# CREATE TABLE IF NOT EXISTS mytable(
#   id SERIAL PRIMARY KEY,
#   name VARCHAR(500) NOT NULL,
#   completed BOOLEAN NOT NULL
# );
# COPY mytable FROM '/var/lib/postgresql/data/init.table.csv' DELIMITER ',' CSV HEADER;


##  Set ssl permission
RUN chmod 400 /temp/ssl/server.key
RUN chown postgres:postgres /temp/ssl/server.key

RUN chmod 400 /temp/ssl/server.crt
RUN chown postgres:postgres /temp/ssl/server.crt

# sym-conf.sh
# To ensure pg_hba and postgresql.conf override the default postgres initialisation.
# Symlink these to: poastgresql_data/conf
# - pg_hba.conf
# - postgresql.conf

COPY ./scripts/sym-conf.sh /docker-entrypoint-initdb.d/sym-conf.sh

CMD ["-c","ssl=on", "-c","ssl_cert_file=/temp/ssl/server.crt","-c","ssl_key_file=/temp/ssl/server.key","-c","ssl_ca_file=/temp/ssl/root.crt"]

