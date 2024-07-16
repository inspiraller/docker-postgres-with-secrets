CREATE TABLE IF NOT EXISTS mytable(
  id SERIAL PRIMARY KEY,
  name VARCHAR(500) NOT NULL,
  completed BOOLEAN NOT NULL
);
COPY mytable FROM '/var/lib/postgresql/data/init.table.csv' DELIMITER ',' CSV HEADER;
