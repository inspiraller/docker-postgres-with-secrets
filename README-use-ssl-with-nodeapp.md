# How to use ssl for interaction via node.js

1. **ssl > server.pem**
- openssl x509 -in server.crt -out server.pem -outform PEM
- cp server.pem ../../../node-app/src/ssl

2. **server-use-ssl.js**
```ts
const pem = fs.readFileSync(path.join(__dirname, './ssl/server.pem')).toString();

const init = () => {
  const pool = createPool(
    `postgresql://${PG_USER}:${PG_PWD}@localhost:5432/${PG_DB}`, {
      ssl: {
        ca: pem,
        rejectUnauthorized: true,
      }
    }
  );
};

init();
```

