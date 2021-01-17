# Home Assistant Add-on: Ecowitt2MQTT

### Overview

This add-on simply wraps the [ecowitt2mqtt](https://github.com/bachya/ecowitt2mqtt) gateway. This gateway can bridge data from a home weather station to Home Assistant without requiring access to a third party API. It's been tested with a [ECOWITT GW1000](https://www.ecowitt.com/shop/goodsDetail/16) using an Ambient Weather sensor kit.

### Installation

1. Make sure the MQTT integration is setup. This add-on will autodiscover the information needed to connect to the broker.
2. Add this add-on via the supervisor.
3. Review the configuration and then start it up.

### Configuration

This is the schema for the configuration (better documentation will come).

````
"hass_discovery": {
    "enabled": "bool",
    "prefix": "str"
},
"mqtt_topic": "str?",
"endpoint": "str?",
"unit_system": "match(imperial|metric)",
"log_level": "match(INFO|WARN|DEBUG)?"
````

The default configuration should work out of the box if you're using the official Mosquitto add-on and allow Home Assistant autodiscovery via MQTT.

The `hass_discovery` settings allow you to turn on and off the auto discovery option. If `enabled` is false, then the add_on will look for the `mqtt_topic` and use that configuration.

The rest of the settings are passthroughs for the underlying `ecowitt2mqtt` library. Check it's readme for more details.