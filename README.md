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

- ### scale with docker service: for loadbalancer testing
```
docker service scale whoami=3
```