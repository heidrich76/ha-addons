#!/usr/bin/with-contenv bashio
# shellcheck shell=bash

if ! bashio::services.available "mqtt" || ! mega-whoami >/dev/null 2>&1; then
  exit 0
fi

MQTT_HOST=$(bashio::services mqtt "host")
MQTT_PORT=$(bashio::services mqtt "port")
MQTT_USER=$(bashio::services mqtt "username")
MQTT_PASS=$(bashio::services mqtt "password")

publish_value() {
  local UNIQUE_ID="$1"
  local NAME="$2"
  local CONFIG_TOPIC="$3"
  local STATE_TOPIC="$4"
  local SIZE="$5"

  local CONFIG_PAYLOAD=$(
    cat <<EOF
{
  "name": "$NAME",
  "state_topic": "$STATE_TOPIC",
  "unit_of_measurement": "MB",
  "device_class": "data_size",
  "unique_id": "$UNIQUE_ID",
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
  mosquitto_pub -h "$MQTT_HOST" -p "$MQTT_PORT" -u "$MQTT_USER" -P "$MQTT_PASS" \
    -t "$STATE_TOPIC" -m "$SIZE"
}

# Local debris size
UNIQUE_ID="mega_local_debris_size"
NAME="Local Debris Size"
CONFIG_TOPIC="homeassistant/sensor/$UNIQUE_ID/config"
STATE_TOPIC="home/$UNIQUE_ID"

# Calculating total size via for loop, because direct call of find caused errors
FOLDERS=(/media /homeassistant /config /backup /share)
SIZE=0
for folder in "${FOLDERS[@]}"; do
  if [ -d "$folder" ]; then
    FOLDER_SIZE=$(find "$folder" -type d -name ".debris" -exec du -smc {} + 2>/dev/null |
      awk '/total$/ {printf "%.0f\n", $1}')
    SIZE=$((SIZE + FOLDER_SIZE))
  fi
done

publish_value $UNIQUE_ID "$NAME" $CONFIG_TOPIC $STATE_TOPIC "$SIZE"

# Cloud debris size
UNIQUE_ID="mega_cloud_debris_size"
NAME="Cloud Debris Size"
CONFIG_TOPIC="homeassistant/sensor/$UNIQUE_ID/config"
STATE_TOPIC="home/$UNIQUE_ID"

SIZE=$(mega-du //bin/SyncDebris | sed -n '2p' |
  awk -F': ' '{gsub(/ /, "", $2); printf "%.0f\n", $2 / 1024 / 1024}')

publish_value $UNIQUE_ID "$NAME" $CONFIG_TOPIC $STATE_TOPIC "$SIZE"
