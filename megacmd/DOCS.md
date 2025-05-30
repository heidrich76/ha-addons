# Home Assistent Add-on: MEGAcmd

The addon provides a recent version of [MEGAcmd](https://github.com/meganz/MEGAcmd/), which was specifically built for this project on [GitHub](https://github.com/heidrich76/megacmd-alpine).
You may interact with MEGAcmd via a web-based Bash shell.
This is work in progress. The files are just provided as-is. Use them at your own risk.

## Installation

Follow these steps to get the add-on installed on your system:

1. This add-on is only visible to "Advanced Mode" users. To enable advanced mode, go to **Profile** -> and turn on **Advanced Mode**.
2. Navigate in your Home Assistant frontend to **Settings** -> **Add-ons** -> **Add-on store**.
3. Find the "Terminal & SSH" add-on and click it.
4. Click on the "INSTALL" button.

## How to use

- After installation, the add-on offers a shell and allows for running standard MEGAcmd commands
- It provides access to the following Home Assistant folders: `/media`, `/backup`, `/share`, and `/config`
- Some basic usage examples:
  - Login: Run `mega-cmd`, type `login <username>`, enter password, and the `exit`
  - In order to use `mega-sync`, machine needs a unique identifier: `uuidgen > /etc/machine-id`
  - Synchronizing folders: Run `mega-sync <local folder> <MEGA folder>`
  - Mount MEGA folder: Run `mega-fuse-add <mount point> <MEGA folder>`
  - Serve MEGA folder/file via WebDAV: `mega-webdav <MEGA folder/file> --public`
    - Allows access from outside container
    - Addon is configured to deliver WebDAV on port `54443`
    - Example access via home assistant `http://homeassistant.local:54443/<id>/<MEGA folder/file>` (`id` is displayed when command is initiated)
  - [Complete MEGAcmd user guide](https://github.com/meganz/MEGAcmd/blob/master/UserGuide.md)

## MEGAcmd add-on sensors

- If a local MQTT server is running on Home Assistant, the addon automatically provides device `MEGA Cloud`
- `MEGA Cloud` comes with two sensors:
  - **Cloud Debris Size**: Size in MB of the trash folder in the MEGA cloud storage
  - **Local Debris Size**: Size in MB of the local trash folders in synchronized folders

## Sending commands to the add-on

You may send commands to the add-on via MQTT:

- Cleaning cloud debris folders:
  ```yaml
  action: mqtt.publish
  data:
    topic: "megacmd/command"
    payload: "clean_cloud_debris"
  ```
- Cleaning local debris folders:
  ```yaml
  action: mqtt.publish
  data:
    topic: "megacmd/command"
    payload: "clean_local_debris"
  ```
