# Orbital Sync

Orbital Sync synchronizes multiple Pi-hole instances for high availability (HA) using the built-in "teleporter". In other words, it performs a "backup" in the Pi-hole admin interface of your primary Pi-hole instance, and then "restores" that backup to any number of "secondary" Pi-holes also via their admin interface. As a result, it supports the synchronization of anything currently supported by Pi-hole's "teleporter".

## Environment variables

Configure the following environment variables when creating the stack:

`PIHOLE_PRIMARY_URL`

The base URL of a Pi-Hole instance to be regarded as primary instance. This means this is the source of truth for the sync and will be used to pull the settings from. Format must be `http://[domain or IP]` or `https://[domain or IP]`.

_Required_: Yes

`PIHOLE_PRIMARY_PATH`

The path to be appended to the base URL of the primary Pi-Hole instance.

_Required_: No

_Default_: `/admin`

`PIHOLE_PRIMARY_PASSWORD`

The web password of the primary Pi-Hole instance.

_Required_: Yes

`PIHOLE_SECONDARY_URL`

The base URL of a Pi-Hole instance to be regarded as secondary instance. Format must be `http://[domain or IP]` or `https://[domain or IP]`.

_Required_: Yes

`PIHOLE_SECONDARY_PATH`

The path to be appended to the base URL of the secondary Pi-Hole instance.

_Required_: No

_Default_: `/admin`

`PIHOLE_SECONDARY_PASSWORD`

The web password of the secondary Pi-Hole instance.

_Required_: Yes

`SYNC_INTERVAL_MINUTES`

The duration in minutes between sync.

_Required_: No

_Default_: `30`
