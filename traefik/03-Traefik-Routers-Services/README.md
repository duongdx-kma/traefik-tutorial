# understanding traefik labels

### explanation: traefik.http.routers.<router_name>.rule

```
1. traefik: docker service
```

```
2. http: protocol
```

```
3. routers: traefik configuration
```

```
4. <router_name>: user defined name for config
```

```
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

### Available Service configurations

```
1. traefik.http.services.<service_name>.loadbalancer.server.port:

eg. "traefik.http.services.whoami.loadbalancer.server.port=8080"
```

```
2. traefik.http.services.<service_name>.loadbalancer.server.passhostheader:

eg. "traefik.http.services.whoami.loadbalancer.server.passhostheader=true"
```

```
3. traefik.http.services.<service_name>.loadbalancer.server.healthcheck.path:

eg. "traefik.http.services.whoami.loadbalancer.server.healthcheck.path=/foo"
```

```
4. traefik.http.services.<service_name>.loadbalancer.server.healthcheck.port:

eg. "traefik.http.services.whoami.loadbalancer.server.healthcheck.port=8088"
```