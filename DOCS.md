## Development

## Using the devcontainer

- Open the project in VS Code
  - Reopen it in the devcontainer (may take some time for the first run)
  - Run the task (Terminal -> Run Task) 'Start Home Assistant', which will bootstrap Supervisor and Home Assistant (may take some time for the first run)
- Run through normal onboarding process at: http://localhost:7123/
  - Configure name / user name / password, e.g., equals test
  - Install required local and online add-ons

## Copy to read Home Assistant server

- Copy add-on to HA samba server (from main addon folder):
  - Windows: `./local_copy.sh //192.168.178.74/addons megacmd`
  - MacOS: `./local_copy.sh /Volumes/addons megacmd`
- Shell to addon container from HA OS: `docker exec -it $(docker ps -f name=addon_local_megacmd -q) bash`

## Links

- Add-on configuration options: https://developers.home-assistant.io/docs/add-ons/configuration/
- Add-on local testing: https://developers.home-assistant.io/docs/add-ons/testing
- Offical add-on builder: https://github.com/home-assistant/builder
- Good reference example for add-ons using s6: https://github.com/home-assistant/addons/tree/master/ssh
- Bashio reference: https://github.com/hassio-addons/bashio
