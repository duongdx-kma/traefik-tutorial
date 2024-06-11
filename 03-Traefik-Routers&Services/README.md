# understanding traefik labels

### explanation: traefik.http.routers.<router_name>.rule

```
1. traefik: docker service
2. http: protocol
3. routers: traefik configuration
4. <router_name>: user defined name for config
5: rule: option
```

### example: "traefik.http.routers.whoami.rule=Host(`whoami.localhost`)"


### Available Router configurations
```
1. traefik.http.routes.<router_name>.rule:

eg. "traefik.http.routers.whoami.rule=Host(`whoami.localhost`)"
```

```
2. traefik.http.routes.<router_name>.entrypoints:

eg. "traefik.http.routers.whoami.entrypoints=ep1,ep2"
```

```
3. traefik.http.routes.<router_name>.service:

eg. "traefik.http.routers.whoami.service=my-service"
```

```
4. traefik.http.routes.<router_name>.tls:

eg. "traefik.http.routers.whoami.tls=true"
```