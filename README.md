# First follow instructions for creating ssl/ into directory from README-create-ssl.md
/dockerise-postgres-with-secrets
  / postgresql_data/
    /ssl

# Create a password  'mypwd' into docker swarm secrets:
1. create password into a sha256
- `printf '%s' 'mypwd' | sha256sum`
> 047c88291e9877788365c59346e6918d54529cdceb7daf1e5cd490493a8e2028 *-

2. Put password into the secrets
- `echo "047c88291e9877788365c59346e6918d54529cdceb7daf1e5cd490493a8e2028 *-" | docker secret create pg_password -`

3. Clear the output from the history
- history
>
```
28  printf '%s' 'mypwd' | sha256sum
29   history
30  history -d 30 && history -w
31  printf '%s' 'mypwd' | sha256sum
32  history
```
- `history -d numberoflastitem && history -w`

# How to stack deploy
- `docker build -t postgres:1 .`
- edit docker-compose.yml to refer now to that image name:
```yaml
services:
  postgres-example-pg-hba:
    image: postgres:1
```

- `docker stack deploy --compose-file=docker-compose.yml secret_test` 
- `docker service ls`
krksqavjzsnx   secret_test_postgres-example-pg-hba   replicated   1/1        image:s   *:5432->5432/tcp
- `docker ps -a`
42e55f728b49   postgres:1   "docker-entrypoint.s…"   12 minutes ago   Up 12 minutes   5432/tcp   secret_test_postgres-example-pg-hba.1.v5z265k9t0ftbullxd89ng8b0

- `docker exec -it 42e55f728b49 psql -U mysuperuser -d mydb`
- Asks for password: [type] mypassword
copy password and just right click into the terminal and press enter

# Inside container
- select * from mytable;
```
 id |     name     | completed
----+--------------+-----------
  1 | Buy pen      | f
  2 | Write letter | f
  3 | Post letter  | f
  4 | Post letter  | f
(4 rows)
```
done!
- exit
\q
CTRL C


# How to interact with db via node-app?
- Follow instruction via README-node-app-to-postgres.md