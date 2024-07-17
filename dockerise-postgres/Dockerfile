FROM postgres:latest

# copy-data.sh  
# postgresql_data/
#   conf/
#   data/
#   ssl/
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
# Note: Don't need to move these anywhere - can refer to them via the cmd 
RUN chmod 400 /temp/ssl/server.key
RUN chown postgres:postgres /temp/ssl/server.key

RUN chmod 400 /temp/ssl/server.crt
RUN chown postgres:postgres /temp/ssl/server.crt

# conf files ownership
# RUN chown postgres:postgres /temp/conf/postgresql.conf
# RUN chown postgres:postgres /temp/conf/pg_hba.conf
COPY ./scripts/copy-conf.sh /docker-entrypoint-initdb.d/copy-conf.sh

ENTRYPOINT ["docker-entrypoint.sh","-c", "ssl=on", "-c","ssl_cert_file=/temp/ssl/server.crt","-c","ssl_key_file=/temp/ssl/server.key","-c","ssl_ca_file=/temp/ssl/root.crt"]
# CMD ["-c", "ssl=on", "-c","ssl_cert_file=/temp/ssl/server.crt","-c","ssl_key_file=/temp/ssl/server.key","-c","ssl_ca_file=/temp/ssl/root.crt"]

