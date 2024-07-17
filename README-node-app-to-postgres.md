# What does node-app do
This is an example of how to interact with the postgres database setup via instruction via the the root README.md
This will simply make a connection to the host and authenticate via ssl, using .env variables and then run a sql command to display the table to via the terminal.

#### pre-requisites
- setup docker postgres
- nodej
- npm, pnpm or yarn

#### copy .env.example to .env
- `cd node-app`
- `cp .env.example .env`

#### install
npm i

#### pnpm start
npm run start

> troubleshoot: name === 'notice' ? new NoticeMessage(length, messageValue) : new DatabaseError(messageValue, length, name)
                                                                    ^
error: no pg_hba.conf entry for host "10.0.0.2", user "mysuperuser", database "mydb", SSL encryption

# Edit: pg_hba.conf
1. `hostssl	 mydb             mysuperuser      10.0.0.2/8            scram-sha-256 # for nodejs to access over ssl ?`
2. View the container id
- `docker ps`
> db08a2575b24   mybuild:1   "docker-entrypoint.s…"   40 minutes ago   Up 40 minutes   5432/tcp   secret_test_postgres-example-pg-hba.1.ao47iu6szau0mqll4945wpf2b
3. copy the new pg_hba.conf
- `cp postgresql_data/conf/pg_hba.conf db08a2575b24:`

4. restart the container to restart the postgres server -
docker restart db08a2575b24
> doesn't work. just creates a new container from the service
5. docker service ls
> cydnyg30y0d5   secret_test_postgres-example-pg-hba   replicated   1/1        mybuild:1   *:5432->5432/tcp
6. docker service rm cydnyg30y0d5
7. docker stack deploy --compose-file=docker-compose.yml secret_test

8. rerun
`npm start`

done!