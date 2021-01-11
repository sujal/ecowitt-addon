#!/usr/bin/with-contenv bashio

# pull MQTT service information
MQTT_HOST=
MQTT_PORT=

# load HA specific options
MQTT_TOPIC=$(bashio::config 'mqtt_topic')
# HASS_DISCOVERY_ENABLED=
HASS_DISCOVERY_PREFIX=

# load ecowitt options
ENDPOINT=
UNIT_SYSTEM=
LOG_LEVEL=

# build out command line arguments
# [-h] --mqtt-broker MQTT_BROKER --mqtt-topic MQTT_TOPIC [--mqtt-port MQTT_PORT]
#                     [--mqtt-username MQTT_USERNAME] [--mqtt-password MQTT_PASSWORD]
#                     [--endpoint ENDPOINT] [--port PORT] [-l LOG_LEVEL]


mqtt_broker="--mqtt-broker=$(bashio::services mqtt 'host')"
mqtt_port="--mqtt-port=$(bashio::services mqtt 'port')"

MQTT_USERNAME=$(bashio::services mqtt "username")
MQTT_PASSWORD=$(bashio::services mqtt "password")
mqtt_username=
mqtt_password=

if [[ ! -z MQTT_USERNAME ]]; then
    mqtt_username="--mqtt-username=${MQTT_USERNAME}"
    mqtt_password"--mqtt-password=${MQTT_PASSWORD}"
fi

# declare variables
mqtt_topic=
hass_discovery =
hass_discovery_prefix=
endpoint=
port=
unit_system=
log_level=

if [ $(bashio::config.true 'hass_discovery.enabled') ]; then  
    
    bashio::log.info "Enabling Home Assistant auto discovery - ignoring MQTT topic if set."

    hass_discovery="--hass-discovery"

    if [ $(bashio::config.has_value 'hass_discovery.prefix') ]; then
        hass_discovery_prefix="--hass-discovery-prefix=$(bashio::config 'hass_discovery.prefix')"
    fi
    
else
    if [ $(bashio::config.has_value 'mqtt_topic') ]; then
        mqtt_topic="--mqtt-topic=$(bashio::config 'mqtt_topic')"
    fi
fi

if [ $(bashio::config.has_value 'endpoint') ]; then
    endpoint="--endpoint=$(bashio::config 'endpoint')"
fi

if [ $(bashio::config.has_value 'port') ]; then
    port="--port=$(bashio::config 'port')"
fi

if [ $(bashio::config.has_value 'unit_system') ]; then
    unit_system="--unit_system=$(bashio::config 'unit_system')"
fi

if [ $(bashio::config.has_value 'log_level') ]; then
    log_level="--log-level=$(bashio::config 'log_level')"
fi

ecowitt2mqtt \
	$mqtt_broker \
	$mqtt_port \
	$mqtt_username \
	$mqtt_password \
	$mqtt_topic \
	$hass_discovery \
	$hass_discovery_prefix \
	$endpoint \
	$port \
	$unit_system \
	$log_level

