# Provision traefik stack:

## I. Prerequisite:

- ### export CLOUDFLARE_API_TOKEN
```
export CLOUDFLARE_API_TOKEN=xxxx-xxxx-xxxx
```

## II. Deploy stack
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

- ### Sync SERVER to CLIENT using Rsync

```
rsync -avz -e "ssh -i client.pem -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --progress ubuntu@13.213.68.133:/tmp/traefik .
```

- ### Sync CLIENT to SERVER using Rsync

```
rsync -avz -e "ssh -i client.pem -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --progress ./traefik ubuntu@13.213.68.133:/tmp/
```