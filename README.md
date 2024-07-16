# Steps for windows user

## Create secret
1. run docker desktop

2. from terminal first create a secret
- `echo "047c88291e9877788365c59346e6918d54529cdceb7daf1e5cd490493a8e2028 *-" | docker secret create pg_password -`

> troubleshoot: Error response from daemon: This node is not a swarm manager. Use "docker swarm init" or "docker swarm join" to connect this node to swarm and try again.
- `docker swarm init`
> To add a worker to this swarm, run the following command:
docker swarm join --token SWMTKN-1-3iho69vnygfax9bcuqr9bif78cj8yzznh6v8lb8egimtltu5on-0p1xnqymg1o8mzackvslm0nij 192.168.65.3:2377

2. Retry create secret
- `echo "047c88291e9877788365c59346e6918d54529cdceb7daf1e5cd490493a8e2028 *-" | docker secret create pg_password -`

3. Clear the bash history terminal so password is not viewable
# Clear my shell
- history
- history -d numberoflastitem && history -w

4. View secrets
- `docker secret ls`

## Create build
1. Create image first - Need a name of the build when using docker stack deploy

- `docker build -t mybuild:1 .`

## Docker stack deploy from image and compose file
1. Now docker stack deploy (will use docker-compose.yml file and refernce the name of the build)
- `docker stack deploy --compose-file=docker-compose.yml secret_test`

2. View the replicated container
- `docker service ls`
> 2vshd2vqf1kz   secret_test_postgres-example-pg-hba   replicated   0/1        mybuild:1   *:5432->5432/tcp

3. View the container
docker ps -a
4. troubleshoot not running
`docker stack ps secret_test`
>iat9caonwup2    \_ secret_test_postgres-example-pg-hba.1   mybuild:1   docker-desktop   Shutdown        Failed 5 seconds ago    "task: non-zero exit (1)"
5. show detail logs
`docker service logs --follow secret_test_postgres-example-pg-hba`
> secret_test_postgres-example-pg-hba.1.q46m0ynpub4i@docker-desktop    | /usr/local/bin/docker-entrypoint.sh: line 21: mysuperuser: No such file or directory
**Solution - create a volume**
- docker-compose.yml
```yml

services:
  postgres-example-pg-hba:
    image: mybuild:1
    secrets: 
      - pg_password
    environment:
      - POSTGRES_DB=mydb
      - POSTGRES_USER=mysuperuser
      - POSTGRES_PASSWORD_FILE=/run/secrets/pg_password
    volumes:
      - postgres-data:/var/lib/postgresql/data
    build:
      context: .
    ports:
          - "5432:5432"
    restart: unless-stopped
    
volumes:
  postgres-data:
```

## Login to container using secret
1. Log into the container (will request the users password which you have to now enter)
- `docker exec -it secret_test_postgres-example-pg-hba psql -U mysuperuser -d mydb`
2. enter: "047c88291e9877788365c59346e6918d54529cdceb7daf1e5cd490493a8e2028 *-
- loggedin

3. exit: `\q` 

## How to prevent user from seeing the passwod?
docker exec -it 42e55f728b49 psql -U mysuperuser -d mydb
-------------
# Close the containers, services, iamges
10. view closed containers (note cannot stop or remove containers. Need to remove service)
`docker ps -a`

11. close service
- `docker service rm 2vshd2vqf1kz`
or try
- `docker stack rm <stack-name>` 
- `docker service scale 2vshd2vqf1kz=0`

Share
Edit
Follow
Flag


done! all closed

12. rm image
`docker rm image:1`
