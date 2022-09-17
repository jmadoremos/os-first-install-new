Build image

```sh
docker image build --rm -t testrun .
```

Run container

```sh
docker container run --rm --name testimg --env env_name=test testrun

IP_ADDR=10.162.10.190 GATEWAY=10.162.10.1 CIDR=10.162.10.0/24 docker compose up --detach
```

Remove container

```sh
docker image rm testrun

docker compose down
```

### TODO

1. Extract environment variables
2. Run script
    1. Recreate nginx.conf
    2. Restart nginx
