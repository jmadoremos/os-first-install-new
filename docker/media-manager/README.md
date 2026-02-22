# Media Manager

This stack creates services to support and manage multimedia files like videos, audios, and ebooks. This stack also includes services to securely download from peer-to-peer torrent clients.

For more information, refer to [What is BitTorrent?](https://help.bittorrent.com/en/support/solutions/articles/29000039924-what-is-bittorrent-) from BitTorrent.

## Containers

* [Calibre-Web Automated](https://github.com/crocodilestick/Calibre-Web-Automated) aims to be an all-in-one solution, combining the modern lightweight web UI from Calibre-Web with the robust, versatile feature set of Calibre, with a slew of extra features and automations thrown in on top.

* [Deluge VPN](https://github.com/binhex/arch-delugevpn) is a full-featured ​BitTorrent client for Linux, OS X, Unix and Windows. This Docker includes OpenVPN and WireGuard to ensure a secure and private connection to the Internet, including use of iptables to prevent IP leakage when the tunnel is down. It also includes Privoxy to allow unfiltered access to index sites, to use Privoxy please point your application at http://<host ip>:8118.

* [Deemix](https://deemix.app/) is a barebone deezer downloader library built from the ashes of Deezloader Remix.

* [FlareSolverr](https://github.com/FlareSolverr/FlareSolverr) is a proxy server to bypass Cloudflare and DDoS-GUARD protection.

* [Lidarr](https://docs.linuxserver.io/images/docker-lidarr/) is a music collection manager for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new tracks from your favorite artists and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.

* [PostgreSQL](https://hub.docker.com/_/postgres), often simply "Postgres", is an object-relational database management system (ORDBMS) with an emphasis on extensibility and standards-compliance. As a database server, its primary function is to store data, securely and supporting best practices, and retrieve it later, as requested by other software applications, be it those on the same computer or those running on another computer across a network (including the Internet). It can handle workloads ranging from small single-machine applications to large Internet-facing applications with many concurrent users. Recent versions also provide replication of the database itself for security and scalability.

* [Prowlarr](https://docs.linuxserver.io/images/docker-prowlarr/) is a indexer manager/proxy built on the popular arr .net/reactjs base stack to integrate with your various PVR apps. Prowlarr supports both Torrent Trackers and Usenet Indexers. It integrates seamlessly with Sonarr, Radarr, Lidarr, and Readarr offering complete management of your indexers with no per app Indexer setup required (we do it all).

* [pgAdmin4](https://hub.docker.com/r/dpage/pgadmin4/) is a web based administration tool for the PostgreSQL database.

* [Radarr](https://docs.linuxserver.io/images/docker-radarr/) is a fork of Sonarr aims to turn it into something like Couchpotato.

* [Sonarr](https://docs.linuxserver.io/images/docker-sonarr/) is a PVR for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new episodes of your favorite shows and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.

## Environment variables

Configure the following environment variables when creating the stack:

### CAPTCHA_SOLVER

Used by lareSolver. Captcha solving method. It is used when a captcha is encountered.

**Required**: No

**Default**: `none`

### DIR_ARR_EXTENDED_COMMON

Used by Radarr and Sonarr. The directory containing *arr extended files for their specific services.

**Required**: Yes

### DIR_CALIBRE_INGEST

Used by Calibre-Web Automated. The directory containing temporary ebooks to be processed by the service.

**Required**: Yes

### DIR_CALIBRE_LIBRARY

Used by Calibre-Web Automated. The directory containing ebooks processed by the service and ready for consumption in the web UI.

**Required**: No

**Default**: `./calibre`

### DIR_DOWNLOADS_ARR

The directory where dowloading and dowloaded movies and TV series are stored. This directory should contain `incomplete` and `completed` directories. For torrents only.

**Required**: Yes

### DIR_DOWNLOADS_DEEMIX

The directory where dowloading and dowloaded music from Deemix are stored.

**Required**: Yes

### DIR_MEDIA_MOVIES

Used by Radarr. The directory containing all movies to be imported and managed.

**Required**: Yes

### DIR_MEDIA_SERIES

Used by Sonarr. The directory containing all tv shows and anime to be imported and managed.

**Required**: Yes

### DIR_RADARR

Used by Radarr. The directory containing its configurations.

**Required**: No

**Default**: `./radarr`

### DIR_SONARR

Used by Radarr. The directory containing its configurations.

**Required**: No

**Default**: `./sonarr`

### HOST_CIDR

The local area network CIDR address. This is passed to the VPN client defined in the container variables.

**Required**: No

**Default**: `192.168.1.0/24`

### LOG_LEVEL

Used by FlareSolverr. Verbosity of the logging. Use `debug` for more information.

**Required**: No

**Default**: `info`

### LOG_HTML

Used by FlareSolverr. Only for debugging. If `true`, all HTML that passes through the proxy will be logged to the console in `debug` level.

**Required**: No

**Default**: `false`

### NAME_SERVERS

A semi-colon delimited list of name servers. This is passed to the VPN client defined in the container variables.

**Required**: No

**Default**: `192.168.1.1`

### PUID

A local user's ID. This allows the containers to map their internal users to a user on the host's machine. For more information, refer to [Understanding PUID and PGID](https://docs.linuxserver.io/general/understanding-puid-and-pgid) by LinuxServer.io.

**Required**: No

**Default**: `1000`

### PGADMIN4_EMAIL

Used by pgAdmin4. This is the default administrator user of pgAdmin4 UI.

**Required**: Yes

### PGADMIN4_PASS

Used by pgAdmin4. This is the default administrator user's password of pgAdmin4 UI.

**Required**: Yes

### PGID

A local group's ID. This allows the containers to map their internal users to a user on the host's machine. For more information, refer to [Understanding PUID and PGID](https://docs.linuxserver.io/general/understanding-puid-and-pgid) by LinuxServer.io.

**Required**: No

**Default**: `1000`

### POSTGRESQL_ADMIN_USER

Used by PostgreSQL. The database instance's initial administrator username.

**Required**: No

**Default**: `iam_user`

### POSTGRESQL_ADMIN_PASS

Used by PostgreSQL. The database instance's initial administrator password.

**Required**: Yes

### SEERR_DB_NAME

Used by Seerr. The database name in PostgreSQL where configurations and its data will be stored.

**Required**: Yes

**Default**: `seerr`

### SEERR_DB_USER

Used by Seerr. The local database username in PostgreSQL where configurations and its data will be stored.

**Required**: Yes

### SEERR_DB_PASS

Used by Seerr. The local database user's password in PostgreSQL where configurations and its data will be stored.

**Required**: Yes

### TRAEFIK_DOMAIN

Used by Traefik (external). The domain owned by the Traefik service where a valid Let's Encrypt certificate was requested.

**Required**: Yes

### TZ

Timezone used in the logs and the web browser.

**Required**: No

**Default**: `Europe/London`

### UMASK

Determines the settings of how permissions are set for newly created files in the containers.

**Required**: No

**Default**: `000`

### VPN_CLIENT

A VPN client used to secure the connection of the BitTorrent client.

**Required**: No

**Allowed values**: `openvpn`, `wireguard`

**Default**: `wireguard`

### VPN_INPUT_PORTS

The ports allowed to receive incoming traffic to the VPN client. Do not set unless the implications are well-understood. For more information, refer to [Q24. I would like to be able to route other docker containers through one of my existing VPN containers, how do i do this?](https://github.com/binhex/documentation/blob/master/docker/faq/vpn.md).

**Required**: No

**Default**: _(no value)_

### VPN_OUTPUT_PORTS

The ports allowed to send outgoing traffic from the VPN client. Do not set unless the implications are well-understood. For more information, refer to [Q24. I would like to be able to route other docker containers through one of my existing VPN containers, how do i do this?](https://github.com/binhex/documentation/blob/master/docker/faq/vpn.md).

**Required**: No

**Default**: _(no value)_

### VPN_PASS

The password from the VPN service provider to connect to the VPN client.

**Required**: No unless using a third-party VPN provider (i.e., `VPN_PROV` != `custom`)

**Default**: _(no value)_

### VPN_PROV

The VPN service provider.

**Required**: No

**Allowed values**: `pia` (Private Internet Access), `airvpn`, `custom` (local)

**Default**: `custom`

### VPN_USER

The username from the VPN service provider to connect to the VPN client.

**Required**: No unless using a third-party VPN provider (i.e., `VPN_PROV` != `custom`)

**Default**: _(no value)_

## Exposed domains and ports

This stack will not expose the individual ports used by any application apart from port `80/TCP`. However, use the following addresses when configuring these applications:

### Calibre-Web Automated domains and port

**Domains**:
- Web domain: [https://calibre.{TRAEFIK_DOMAIN}/](https://calibre.{TRAEFIK_DOMAIN}/)
- Alternative web domain: [https://ebooks.{TRAEFIK_DOMAIN}/](https://ebooks.{TRAEFIK_DOMAIN}/)
- Container domain: [http://calibre.traefik-vlan/](http://calibre.traefik-vlan/)

**Container port**: 8083

### Deluge VPN domains and port

**Domains**:
- Web domain: [https://deluge.{TRAEFIK_DOMAIN}/](https://deluge.{TRAEFIK_DOMAIN}/)
- Container domain: [http://deluge.traefik-vlan/](http://deluge.traefik-vlan/)

**Container port**: 8112

### Deemix domains and port

**Domains**:
- Web domain: [https://deemix.{TRAEFIK_DOMAIN}/](https://deemix.{TRAEFIK_DOMAIN}/)
- Container domain: [http://deemix.traefik-vlan/](http://deemix.traefik-vlan/)

**Container port**: 6595

### FlareSolverr domains and port

**Domains**:
- Web domain: [https://flaresolverr.{TRAEFIK_DOMAIN}/](https://flaresolverr.{TRAEFIK_DOMAIN}/)
- Container domain: [http://flaresolverr.traefik-vlan/](http://flaresolverr.traefik-vlan/)

**Container port**: 8191

### Prowlarr domains and port

**Domains**:
- Web domain: [https://prowlarr.{TRAEFIK_DOMAIN}/](https://prowlarr.{TRAEFIK_DOMAIN}/)
- Container domain: [http://prowlarr.traefik-vlan/](http://prowlarr.traefik-vlan/)

**Container port**: 9696

### pgAdmin4 domains and port

**Domains**:
- Web domain: [https://pgadmin4.{TRAEFIK_DOMAIN}/](https://pgadmin4.{TRAEFIK_DOMAIN}/)
- Container domain: [http://pgadmin4.traefik-vlan/](http://pgadmin4.traefik-vlan/)

**Container port**: 80

### Radarr domains and port

**Domains**:
- Web domain: [https://radarr.{TRAEFIK_DOMAIN}/](https://radarr.{TRAEFIK_DOMAIN}/)
- Container domain: [http://radarr.traefik-vlan/](http://radarr.traefik-vlan/)

**Container port**: 7878

### Seerr domains and port

**Domains**:
- Web domain: [https://seerr.{TRAEFIK_DOMAIN}/](https://seerr.{TRAEFIK_DOMAIN}/)
- Container domain: [http://seerr.traefik-vlan/](http://seerr.traefik-vlan/)

**Container port**: 5055

### Sonarr domains and port

**Domains**:
- Web domain: [https://sonarr.{TRAEFIK_DOMAIN}/](https://sonarr.{TRAEFIK_DOMAIN}/)
- Container domain: [http://sonarr.traefik-vlan/](http://sonarr.traefik-vlan/)

**Container port**: 8989

## Configurations

### 1. Setup Deluge VPN.

1. Using any internet browser, navigate to its URL as mentioned in [Deluge VPN domains and port](#deluge-vpn-domains-and-port) section.

2. The default (Old) password is `deluge`. Replace the password with a new value in the **WebUI Password** field of **Interface** page of the **Preferences** dialog box.

3. In the same **Preferences** dialog box, enable the **Label** plug-in of the **Plug-ins** page.

### 2. Setup Deemix.

1. Using any internet browser, navigate to its URL as mentioned in [Deemix domains and port](#deemix-domains-and-port) section.

2. Go to the **Settings** page, and login to [Deezer](https://deezer.com/).

### 3. Setup PostgreSQL database instance.

1. Using any internet browser, navigate to pgAdmin4's URL as mentioned in [pgAdmin4 domains and port](#pgadmin4-domains-and-port) section.

2. Login using the username and password specified in the `PGADMIN4_EMAIL` and `PGADMIN4_PASS` environment variables, respectively.

3. Create a user for each of the **Radarr** and **Sonarr** instances.

    ```sql
    CREATE USER "iam_instance_user" WITH PASSWORD 'iam_instance_password' CONNECTION LIMIT 20;
    ```

    > Replace `iam_instance_user` with the desired local DB username for the current instance. Best practice to create a user for each instance to isolate database access.

    > Replace `iam_instance_password` with a random password for the local DB user. Use only alphanumeric characters to avoid issues. Best practice to set at least 36 characters.

4. Create two databases for each of the **Radarr** and **Sonarr** instances.

    ```sql
    CREATE DATABASE "instance_identifier" WITH OWNER = "iam_user";

    CREATE DATABASE "instance_identifier-log" WITH OWNER = "iam_user";
    ```

    > Replace `instance_identifier` with the Docker compose service name.

    > Replace `iam_user` with the value of `POSTGRESQL_ADMIN_USER` environment variable.

5. Connect to the first database (i.e., `instance_identifier`) and run this query to grant the necessary permissions.

    ```sql
    GRANT ALL PRIVILEGES ON DATABASE "instance_identifier" TO "iam_instance_user";

    GRANT USAGE, CREATE ON SCHEMA "public" TO "iam_instance_user";
    ```

    > Replace `instance_identifier` with the Docker compose service name.

    > Replace `iam_instance_user` with the created local DB username for the current instance.

6. Connect to the second database (i.e., `instance_identifier-log`) and rin this query to grant the necessary permissions.

    ```sql
    GRANT ALL PRIVILEGES ON DATABASE "instance_identifier-log" TO "iam_instance_user";

    GRANT USAGE, CREATE ON SCHEMA "public" TO "iam_instance_user";
    ```

    > Replace `instance_identifier` with the Docker compose service name.

    > Replace `iam_instance_user` with the created local DB username for the current instance.

7. Update each instance's **/config/Config.xml** file to add the **PostgreSQL** database connection.

    ```xml
    <PostgresHost>postgresql.database-vlan</PostgresHost>
    <PostgresPort>5432</PostgresPort>
    <PostgresUser>iam_instance_user</PostgresUser>
    <PostgresPassword>iam_instance_password</PostgresPassword>
    <PostgresMainDb>instance_identifier</PostgresMainDb>
    <PostgresLogDb>instance_identifier-log</PostgresLogDb>
    ```

    > Replace `iam_instance_user` with the created local DB username for the current instance.

    > Replace `iam_instance_password` with the created local DB user's password for the current instance.

    > Replace `instance_identifier` with the Docker compose service name.

8. Start each of the **Radarr** and **Sonarr** instances to initialize the databases. This will create the necessary tables and initial data on each table.

9. **Optional.** If migrating from an existing instance where SQLite was used,

    1. Stop the instance to prevent corrupting the data in SQLite.

    2. Using **pgAdmin4**, connect to the `instance_identifier` database and run this query to delete conflict data.

        ```sql
        DELETE FROM "QualityProfiles";
        DELETE FROM "QualityDefinitions";
        DELETE FROM "DelayProfiles";
        DELETE FROM "Metadata";
        ```

        > Replace `instance_identifier` with the Docker compose service name.

        > Replace `iam_user` with the value of `POSTGRESQL_ADMIN_USER` environment variable.

    3. Using any terminal connected to the Docker host, run this command to migrate primary instance's data from SQLite to PostgreSQL.

        * For Prowlarr,

            ```sh
            docker run --rm -v DOCKER_VOLUME_OR_HOST_PATH:/config:rw ghcr.io/roxedus/pgloader --with "quote identifiers" --with "data only" --with "prefetch rows = 100" --with "batch size = 1MB" /config/prowlarr.db "postgresql://POSTGRESQL_ADMIN_USER:POSTGRESQL_ADMIN_PASS@postgresql.database-vlan/instance_identifier"

            docker run --rm -v DOCKER_VOLUME_OR_HOST_PATH:/config:rw ghcr.io/roxedus/pgloader --with "quote identifiers" --with "data only" --with "prefetch rows = 100" --with "batch size = 1MB" /config/logs.db "postgresql://POSTGRESQL_ADMIN_USER:POSTGRESQL_ADMIN_PASS@postgresql.database-vlan/instance_identifier-log"
            ```

            > Replace `DOCKER_VOLUME_OR_HOST_PATH` with the Docker volume name or host path containing the instance's config folders and files.

            > Replace `POSTGRESQL_ADMIN_USER` with the value of the environment variable of the same name.

            > Replace `POSTGRESQL_ADMIN_PASS` with the value of the environment variable of the same name.

            > Replace `instance_identifier` with the Docker compose service name.

        * For Radarr,

            ```sh
            docker run --rm -v DOCKER_VOLUME_OR_HOST_PATH:/config:rw ghcr.io/roxedus/pgloader --with "quote identifiers" --with "data only" --with "prefetch rows = 100" --with "batch size = 1MB" /config/radarr.db "postgresql://POSTGRESQL_ADMIN_USER:POSTGRESQL_ADMIN_PASS@postgresql.database-vlan/instance_identifier"

            docker run --rm -v DOCKER_VOLUME_OR_HOST_PATH:/config:rw ghcr.io/roxedus/pgloader --with "quote identifiers" --with "data only" --with "prefetch rows = 100" --with "batch size = 1MB" /config/logs.db "postgresql://POSTGRESQL_ADMIN_USER:POSTGRESQL_ADMIN_PASS@postgresql.database-vlan/instance_identifier-log"
            ```

            > Replace `DOCKER_VOLUME_OR_HOST_PATH` with the Docker volume name or host path containing the instance's config folders and files.

            > Replace `POSTGRESQL_ADMIN_USER` with the value of the environment variable of the same name.

            > Replace `POSTGRESQL_ADMIN_PASS` with the value of the environment variable of the same name.

            > Replace `instance_identifier` with the Docker compose service name.

        * For Sonarr,

            ```sh
            docker run --rm -v DOCKER_VOLUME_OR_HOST_PATH:/config:rw ghcr.io/roxedus/pgloader --with "quote identifiers" --with "data only" --with "prefetch rows = 100" --with "batch size = 1MB" /config/sonarr.db "postgresql://POSTGRESQL_ADMIN_USER:POSTGRESQL_ADMIN_PASS@postgresql.database-vlan/instance_identifier"

            docker run --rm -v DOCKER_VOLUME_OR_HOST_PATH:/config:rw ghcr.io/roxedus/pgloader --with "quote identifiers" --with "data only" --with "prefetch rows = 100" --with "batch size = 1MB" /config/logs.db "postgresql://POSTGRESQL_ADMIN_USER:POSTGRESQL_ADMIN_PASS@postgresql.database-vlan/instance_identifier-log"
            ```

            > Replace `DOCKER_VOLUME_OR_HOST_PATH` with the Docker volume name or host path containing the instance's config folders and files.

            > Replace `POSTGRESQL_ADMIN_USER` with the value of the environment variable of the same name.

            > Replace `POSTGRESQL_ADMIN_PASS` with the value of the environment variable of the same name.

            > Replace `instance_identifier` with the Docker compose service name.

    4. Using **pgAdmin4**, connect to the `instance_identifier` database and run this query to realign the primary key sequences based on the current max record. This will go through all tables.

        ```sql
        DO $$
        DECLARE
            r RECORD;
        BEGIN
            FOR r IN
                -- Find all sequences in the public schema associated with table columns
                SELECT
                    table_schema,
                    table_name,
                    column_name,
                    pg_get_serial_sequence(concat(table_schema,'.','"',table_name,'"'), column_name) AS seq_name
                FROM information_schema.columns
                WHERE table_schema = 'public'
                AND column_default LIKE 'nextval%'
            LOOP
                -- Only attempt update if a sequence is actually found for that column
                IF r.seq_name IS NOT NULL THEN
                    EXECUTE format(
                        'SELECT setval(%L, COALESCE((SELECT MAX(%I) FROM %I.%I), 1), true)',
                        r.seq_name,
                        r.column_name,
                        r.table_schema,
                        r.table_name
                    );
                END IF;
            END LOOP;
        END $$;
        ```

    5. Start the instance to complete the data migration.

### 4. Setup Radarr and Sonarr.

1. Using any internet browser, navigate to their URLs as mentioned in [Radarr domains and port](#radarr-domains-and-port) and [Sonarr domains and port](#sonarr-domains-and-port) sections.

2. Connect each of these applications to the **Deluge VPN** by adding a new entry in **Download Clients** section of **Settings > Download Clients** page.

    1. Use the [container domain of Deluge VPN](#deluge-vpn-domains-and-port) in the **Host** field.

    2. Specify the new password in the **Password** field.

    3. Update the **Category** field to **Radarr** or **Sonarr** based on which application is being updated.

    4. Click the Test button to test the connection. The button should change to a check mark.

    5. Click the Save button.

3. During the setup, copy the **API Key** in **Settings > General** page to be used when connecting **Prowlarr** to these applications.

### 5. Setup Prowlarr.

1. Using any internet browser, navigate to their URLs as mentioned in [Prowlarr domains and port](#prowlarr-domains-and-port) section.

2. Connect **Radarr**, and **Sonarr** by adding a new entry in **Applications** section of **Settings > Apps** page.

    1. Use the [domain of Prowlarr](#prowlarr-domains-and-port) in the **Prowlarr Server** field.

    2. Use the [domain of each application](#exposed-ports) in the **Radarr Server** and **Sonarr Server** fields.

    3. Specify the appropriate API key copied from step #2.2 in the **ApiKey** field.

    4. Click the Test button to test the connection. The button should change to a check mark.

    5. Click the Save button.

3. Connect **Deluge VPN** by adding a new entry in **Download Clients** section of **Settings > Download Clients** page.

    1. Use the [container domain of Deluge VPN](#deluge-vpn-domains-and-port) in the **Host** field.

    2. Specify the new password in the **Password** field.

    3. Update the **Category** field to **Prowlarr**.

    4. Click the **Test** button to test the connection. The button should change to a check mark.

    5. Click the **Save** button.

4. Connect **Flaresolverr** by adding a new indexer proxy in **Indexer Proxies** section of **Settings > Indexers** page.

    1. Use the [IP address of deluge-vpn](#exposed-ports) in the **Host** field.

    2. Specify any name.

    3. Specify `flaresolverr` in the **Tags** field. This will ensure that all indexers that use the `flaresolverr` tag will proxy through FlareSolverr.

    4. Click the **Save** button.

5. Add Indexers by clicking the **+ Add Indexer** button in the **Indexers** page.

    > For indexers with **FlareSolverr** section in the **Edit Indexer** page, add the `flaresolverr` in the **Tags** field.

### 6. Setup Seerr.

1. Using any internet browser, navigate to their URLs as mentioned in [Seerr domains and port](#seerr-domains-and-port) section.

2. Login to **Plex**.

3. Connect to a **Plex Media Server** and select the libraries to sync.

4. For **Radarr** instances,

    1. Click **+ Add Radarr Server** button.

    2. Specify the following values:

        * **Default Server**: _`Yes` if it is the primary instance, otherwise `No` for the rest_.

        * **4K Server**:  _`No` if for any other instance except those handling 4K movies, otherwise `Yes` for the rest_.

        * **Server Name**: _Any name desired that differentiates Radarr instances_.

        * **Hostname or IP Address**: _Refer to [domain of each application](#radarr-domains-and-port) for the domain but use only their `*.traefik-vlan` domains_.

        * **Port**: _Refer to [container port of each application](#radarr-domains-and-port) for the port_.

        * **Use SSL**: `No`.

        * **API Key**: _Specify the appropriate API key copied from step #2.2 in the **ApiKey** field_.

        * **Quality Profile**: _Click the **Test** button first to load options, then select `Any` as value_.

        * **Root Folder**: _Options should have loaded after clicking the **Test** button, then select desired value_.

        * **Minimum Availability**: `Released`.

        * **Tags**: _Don't select any value_.

        * **External URL**: _Blank_.

        * **Enable Scan**: `No`.

        * **Enable Automatic Search**: `Yes`.

    3. Click **Add Server** button.

    4. Repeat for the other Radarr instances.

5. For **Sonarr**,

    1. Click **+ Add Sonarr Server** button.

    2. Specify the following values:

        * **Default Server**: _`Yes` if it is the primary instance, otherwise `No` for the rest_.

        * **4K Server**: `No`.

        * **Server Name**: _Any name desired that differentiates the Sonarr instances_.

        * **Hostname or IP Address**: _Refer to [domain of each application](#sonarr-domains-and-port) for the domain but use only their `*.traefik-vlan` domains_.

        * **Port**: _Refer to [container port of each application](#sonarr-domains-and-port) for the port_.

        * **Use SSL**: `No`.

        * **API Key**: _Specify the appropriate API key copied from step #2.2 in the **ApiKey** field_.

        * **Quality Profile**: _Click the **Test** button first to load options, then select `Any` as value_.

        * **Root Folder**: _Options should have loaded after clicking the **Test** button, then select desired value_.

        * **Language Profile**: `English`if TV Series, `Sub/Dub` if Anime.

        * **Tags**: _Don't select any value_.

        * **Anime Quality Profile**: _Don't select any value if TV Series, select `Any` if Anime_.

        * **Anime Root Folder**: _Don't select any value if TV Series, select desired value if Anime_.

        * **Anime Language Profile**: _Don't select any value_.

        * **Anime Tags**: _Don't select any value if TV Series, `Sub/Dub` if Anime_.

        * **Season Folders**: `Yes`.

        * **External URL**: `Blank`.

        * **Enable Scan**: `No`.

        * **Enable Automatic Search**: `Yes`.

    3. Click **Add Server** button.

    4. Repeat for the other Sonarr instances, if any.

6. Click **Finish Setup** button to continue.
