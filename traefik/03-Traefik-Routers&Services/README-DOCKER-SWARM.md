
- ### generate basic authentication for user:
```
echo $(htpasswd -nB duongdx) | sed -e s/\\$/\\$\\$/g

duongdx:$$2y$$05$$G01EAMot6n2rmushO6v28.auOqg9ayoh7qTK13QDwIuHkwyV/brhG
```
- ### create docker swarm
```
docker swarm init --advertise-addr 192.168.56.111
```

- ### To add a worker to this swarm, run the following command:
```
docker swarm join \
    --token token_string \
    192.168.56.111
```

- ### deploy stack to docker swarm:
```
docker stack deploy -c docker-compose.yml traefik
```

- ### scale with docker service: for loadbalancer testing
```
docker service scale whoami=3
```

- ### Testing from local to traefik server:
```
# command:
curl -H Host:whoami.localhost 192.168.56.111

# result:
Hostname: 33c5c253fc2d
IP: 127.0.0.1
IP: 172.18.0.2
RemoteAddr: 172.18.0.3:41720
GET / HTTP/1.1
Host: whoami.localhost
User-Agent: curl/7.68.0
Accept: */*
Accept-Encoding: gzip
X-Forwarded-For: 192.168.56.1
X-Forwarded-Host: whoami.localhost
X-Forwarded-Port: 80
X-Forwarded-Proto: http
X-Forwarded-Server: 570e9a3c5241
X-Real-Ip: 192.168.56.1
```

- ### scale with docker service: for loadbalancer testing
```
docker service scale whoami=3
```