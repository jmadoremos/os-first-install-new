# Home Automation

This stack creates services to support and manage home automation.

## Containers

* [Home Assistant](https://www.home-assistant.io/) is an open source home automation that puts local control and privacy first. Powered by a worldwide community of tinkerers and DIY enthusiasts.

## Environment variables

Configure the following environment variables when creating the stack:

`DIR_HOME_ASSISTANT`

Used to store the configuration files of Home Assistant.

_Required_: Yes

_Default_: `none`

## Exposed ports

This stack will not expose the individual ports used by any application apart from port `80/TCP`. However, use the following addresses when configuring these applications:

* `homeassistant` address: `http://10.81.23.2:8123/`
