#!/usr/bin/with-contenv bashio

if ! bashio::services.available "mqtt" || ! mega-whoami >/dev/null 2>&1; then
  exit 0
fi

MQTT_HOST=$(bashio::services mqtt "host")
MQTT_PORT=$(bashio::services mqtt "port")
MQTT_USER=$(bashio::services mqtt "username")
MQTT_PASS=$(bashio::services mqtt "password")

# Local debris size
CONFIG_TOPIC="homeassistant/sensor/mega_local_debris_size/config"
STATE_TOPIC="home/mega_local_debris_size"

CONFIG_PAYLOAD=$(
  cat <<EOF
{
  "name": "Local Debris Size",
  "state_topic": "$STATE_TOPIC",
  "unit_of_measurement": "MB",
  "device_class": "data_size",
  "unique_id": "mega_local_debris_size",
  "device": {
    "identifiers": ["mega_cloud"],
    "name": "MEGA Cloud",
    "model": "Properties",
    "manufacturer": "MEGA"
  }
}
EOF
)

mosquitto_pub -h "$MQTT_HOST" -p "$MQTT_PORT" -u "$MQTT_USER" -P "$MQTT_PASS" \
  -t "$CONFIG_TOPIC" -m "$CONFIG_PAYLOAD"

SIZE=$(du -sm /media/mega/*/.debris 2>/dev/null | awk '{sum+=$1} END {printf "%.0f\n", sum}')
mosquitto_pub -h "$MQTT_HOST" -p "$MQTT_PORT" -u "$MQTT_USER" -P "$MQTT_PASS" \
  -t "$STATE_TOPIC" -m "$SIZE"

# Cloud debris size
CONFIG_TOPIC="homeassistant/sensor/mega_cloud_debris_size/config"
STATE_TOPIC="home/mega_cloud_debris_size"

CONFIG_PAYLOAD=$(
  cat <<EOF
{
  "name": "Cloud Debris Size",
  "state_topic": "$STATE_TOPIC",
  "unit_of_measurement": "MB",
  "device_class": "data_size",
  "unique_id": "mega_cloud_debris_size",
  "device": {
    "identifiers": ["mega_cloud"],
    "name": "MEGA Cloud",
    "model": "Properties",
    "manufacturer": "MEGA"
  }
}
EOF
)

mosquitto_pub -h "$MQTT_HOST" -p "$MQTT_PORT" -u "$MQTT_USER" -P "$MQTT_PASS" \
  -t "$CONFIG_TOPIC" -m "$CONFIG_PAYLOAD"

SIZE=$(mega-du //bin/SyncDebris | sed -n '2p' | awk -F': ' '{gsub(/ /, "", $2); printf "%.0f\n", $2 / 1024 / 1024}')
mosquitto_pub -h "$MQTT_HOST" -p "$MQTT_PORT" -u "$MQTT_USER" -P "$MQTT_PASS" \
  -t "$STATE_TOPIC" -m "$SIZE"
