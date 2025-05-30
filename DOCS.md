# Development Notes

## Using the Devcontainer

1. Open the project in VS Code.

   - Reopen it in the devcontainer (initial setup may take some time).
   - Run the task **"Start Home Assistant"** (`Terminal` → `Run Task`), which will bootstrap Supervisor and Home Assistant (also may take some time initially).

2. Complete the onboarding process at [http://localhost:7123/](http://localhost:7123/):

   - Set name, username, and password (e.g., all set to `test`).
   - Install required local and online add-ons.

3. During development, **comment out** the `image` key in `example/config.yaml` to let the Supervisor build the add-on.

   - **Important:** Re-enable the `image` key before pushing your changes.

4. When merging into the `main` branch:

   - Update the `version` in `example/config.yaml`.
   - Update the changelog in `example/CHANGELOG.md`.

## Copying to a Local Home Assistant Server

To copy the add-on to a local HA Samba share:

- **Windows:**

  ```sh
  ./local_copy.sh //192.168.178.74/addons megacmd
  ```

- **macOS:**

  ```sh
  ./local_copy.sh /Volumes/addons megacmd
  ```

To open a shell in the add-on container on HA OS:

```sh
docker exec -it $(docker ps -f name=addon_local_megacmd -q) bash
```

## Development Resources

- [Add-on configuration options](https://developers.home-assistant.io/docs/add-ons/configuration/)
- [Local testing of add-ons](https://developers.home-assistant.io/docs/add-ons/testing)
- [Example add-on repository](https://github.com/home-assistant/addons-example/)
- [Official add-on builder](https://github.com/home-assistant/builder)
- [Reference add-on using s6](https://github.com/home-assistant/addons/tree/master/ssh)
- [Bashio reference](https://github.com/hassio-addons/bashio)
