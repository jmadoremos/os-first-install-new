# Dockerized DeezLoader

Official documentation in https://pypi.org/project/deezloader.

## Installation

Create a docker image.

> Requires [Docker](https://docs.docker.com/get-docker/) to be installed. Make sure the docker service is not running as root for security purposes.

```sh
docker build -t an0nimia/deezloader docker/deezloader/
```

## Setting up the settings.ini file

1. Download the file `docker/deezloader/res/settings.ini` to any local folder. For this example, the file is stored in `/export/containers/deezloader/` folder.

2. Login to [Deezer](https://www.deezer.com/) using any web browser.

3. After successful login, copy the value of `arl` cookie. This can be accessed using the Dev Console feature of any web browser.

4. Update the downloaded `settings.ini` file by replacing the `#` character and all texts after with actual values like user email, password, and the copied `arl` value. Don't forget to save the changes.

5. If using linux-based OS, update the permissions to the `settings.ini` file to limit access to the file.

```sh
sudo chmod 640 settings.ini
```

## Using the docker image

Create a container to host the Web API version of DeezLoader.

> After starting the container, the API can be accessed through http://127.0.0.1:8088/docs. Port `8000` is mapped to `8088` of the host to avoid port conflict with existing services including Docker.

```sh
docker container create \
  -v "/export/containers/deezloader/settings.ini:/.deez_settings.ini:ro" \
  -p 8088:8000 \
  --name deezloader \
  an0nimia/deezloader:latest
```

Or, run a volatile container to run the CLI version of DeezLoader.

> For this example, the command will display the help section of the CLI.

```sh
docker run \
  -v "/export/containers/deezloader/settings.ini:/.deez_settings.ini:ro" \
  --rm -i -t an0nimia/deezloader:latest \
  deez-dw.py -h
```
