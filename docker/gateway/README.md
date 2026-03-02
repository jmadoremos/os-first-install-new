# Gateway

This stack creates gateway services that handle secure traffic between containers.

## Containers

* [Traefik](https://traefik.io/traefik) is an open-source Application Proxy and the core of the Traefik Hub Runtime Platform.

* [Wireguard](https://www.wireguard.com/) is an extremely simple yet fast and modern VPN that utilizes state-of-the-art cryptography. It aims to be faster, simpler, leaner, and more useful than IPsec, while avoiding the massive headache. It intends to be considerably more performant than OpenVPN. WireGuard is designed as a general purpose VPN for running on embedded interfaces and super computers alike, fit for many different circumstances. Initially released for the Linux kernel, it is now cross-platform (Windows, macOS, BSD, iOS, Android) and widely deployable. It is currently under heavy development, but already it might be regarded as the most secure, easiest to use, and simplest VPN solution in the industry.

## Environment variables

Configure the following environment variables when creating the stack:

### CLOUDFLARE_TUNNEL_TOKEN

Used by Cloudflared. This is the API token to authenticate with Cloudflare.

**Required**: Yes

### DIR_TAILSCALE

Used by Tailscale. This is the directory containing its configuration files.

**Required**: No

**Default**: `./tailscale`

### DIR_TRAEFIK

Used by Traefik. This is the directory containing its configuration files. This directory must contain the **dynamic_conf/config.yaml**, **dynamic_conf/shared.yaml**, and **traefik.yaml** files.

**Required**: No

**Default**: `./traefik`

### DIR_WIREGUARD

Used by Wireguard. This is the directory containing its configuration files including peer connection details.

**Required**: No

**Default**: `./wireguard`

### IPV4_ADDR

Used by Traefik. This is the IPv4 address from the host network that Traefik can listen for traffic.

**Required**: Yes

### HOST_CIDR

The local area network CIDR address. This is passed to `macvlan` configuration where Traefik will listen for incoming traffic.

**Required**: Yes

### HOST_GATEWAY

The local area network gateway address. This is passed to `macvlan` configuration where Traefik will listen for incoming traffic.

**Required**: Yes

### HOST_IPADDR

Used by Wireguard. The local area network host IP address. This is address where it will listen for incoming traffic on port `51820`.

**Required**: No

**Default**: `127.0.0.1`

### DNS_SERVER

Used by Wireguard. The domain name server to resolve CNAME requests to IP addresses. This is where outgoing traffic from its peer connections will resolve domains.

**Required**: No

**Default**: `127.0.0.1`

### NETWORK_INTERFACE

The local network interface. This is passed to `macvlan` configuration where Traefik will listen for incoming traffic.

**Required**: No

**Default**: `eth0`

### PGID

A local group's ID. This allows the containers to map their internal users to a user on the host's machine. For more information, refer to [Understanding PUID and PGID](https://docs.linuxserver.io/general/understanding-puid-and-pgid) by LinuxServer.io.

**Required**: No

**Default**: `1000`

### PUID

A local user's ID. This allows the containers to map their internal users to a user on the host's machine. For more information, refer to [Understanding PUID and PGID](https://docs.linuxserver.io/general/understanding-puid-and-pgid) by LinuxServer.io.

**Required**: No

**Default**: `1000`

### TAILSCALE_OAUTH_SECRET

Used by Tailscale. This is the Oauth secret used to authenticate with the global service.

**Required**: Yes

### TRAEFIK_DOMAIN

Used by Traefik. This is a valid and owned internet (public-facing) domain registered in ICANN. This will be used as the base domain of all hosts served by Traefik.

**Required**: Yes

### TZ

The time zone to report the time of requests made.

**Required**: No

**Default**: `Asia/Manila`

### WIREGUARD_PEERS

Used by Wireguard. This is a comma-separated list of named peers. Wireguard will create connection configurations for each peer in this list.

**Required**: Yes

## Exposed domains and ports

This stack will expose the following ports per service:

### Traefik domains and port

**Domains**:
- Web domain: [https://traefik-dashboard.{TRAEFIK_DOMAIN}/](https://traefik-dashboard.{TRAEFIK_DOMAIN}/)
- Container domain: [http://traefik.traefik-vlan/](http://traefik.traefik-vlan/)

**Container ports**:
- HTTP: `80` (auto-redirected to HTTPS)
- HTTPS: `443`
- DNS (TCP): `53`
- DNS (UDP): `53`

### Wireguard domains and port

**Domains**:
_No domains._

**Container ports**:
- TCP: `51820`
- UDP: `51820`

### Tailscale domains and port

**Domains**:
_No domains._

**Container ports**:
_No ports._

## Configurations

### 1. Create Cloudflare API token.

1. Using any internet browser, navigate to [Cloudflare Dashboard](https://dash.cloudflare.com/). You may be asked to login if no session is open.

2. Click the **Manage account** section in the left navigation panel. This will expand the section.

3. Click the **Account API tokens** subsection. This will open the **Account API tokens** page.

4. Click the **Create** button to create a new token.

5. Click the **Get started** button on the **Create Custom Token** section.

6. Populate the fields as follows:
    - **Name**: `Traefik`
    - **Permissions**:
        - **Type**: `Zone`
          **Permission**: `DNS`
          **Access**: `Edit`
        - **Type**: `Zone`
          **Permission**: `Zone`
          **Access**: `Read`
    - **Zone Resources**:
        - **Type**: `Include`
          **Scope**: `Specific zone`
          **Zone**: _The primary domain of the `TRAEFIK_DOMAIN` value._

7. Click **Continue to summary** button to review the changes.

8. Click **Submit** to create the token. Take note of the value as this will never be shown again.

### 2. Setup Traefik.

1. Create a file named **cloudflare_api_key.txt** inside the [Traefik directory](#dir_traefik). Set its content to the token value from [Step 1](#1-create-cloudflare-api-token).

2. After mounting the necessary volumes, directories, and files for this stack, update the [Traefik.yaml](./res/traefik.yaml) file to change **log.level** to `DEBUG` and **certificatesResolvers.cloudflare.caServe** to `https://acme-staging-v02.api.letsencrypt.org/directory`.

3. Create and run the stack. Check the Docker logs for details on the certificate creation and renewal request.

4. When successful, stop the **traefik** container.

5. Update the [Traefik.yaml](./res/traefik.yaml) file to change **log.level** to `INFO` and **certificatesResolvers.cloudflare.caServe** to `https://acme-v02.api.letsencrypt.org/directory`.

6. Run the **traefik** container.

7. Update the **dynamic_conf/config.yaml** file with the static file-provided routers and services. If updated outside of the **traefik** container instance, create an interactive terminal session to the container using `docker exec -it traefik /bin/sh` and update the timestamp of the configuration file using `vi /etc/traefik/dynamic_conf/config.yaml` and `:wq` even without writing any changes.
