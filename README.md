## Acknowledgments

- [dani-garcia/vaultwarden](https://github.com/dani-garcia/vaultwarden)

## <a id="Overview"></a>Overview

This repo is for deploying [Vaultwarden](https://github.com/dani-garcia/vaultwarden) on various PaaS platforms (Render, Koyeb, Northflank, fly.io, etc.).

## <a id="Deployment"></a>Deployment

### <a id="Envionment_Variables"></a>Envionment Variables

| Variable | Default | Description |
| :--- | :--- | :--- |
| `SIGNUPS_ALLOWED` | true | Controls if new users can register |
| `WEBSOCKET_ENABLED` | true | Enables websocket notifications |
| `IP_HEADER` | X-Forwarded-For | Client IP Header, used to identify the IP of the client. "X-Forwarded-For" is not very reliable, but it's the best way to get client ip addr inside PaaS service. |
| `ADMIN_TOKEN` | | Token for the admin interface, preferably use a long random string. If not set, the admin panel is disabled. |
| `DATABASE_URL` | data/db.sqlite3 | Default value is for PaaS services with persistent storage volume, and you need to mount persistent storage volume to "/data". Otherwise you need to specify an database URI for data persistent.  |

For detailed explanation of database URI and the rest of Envionment Variables, head to [Vaultwarden's documentation](https://github.com/dani-garcia/vaultwarden/blob/main/.env.template).

### Deploy to Render, Northflank etc.
- Link your forked repo in PaaS platform's dashboard
- Set envs
- Deploy

### Deploy to Koyeb
- Create a new release in your forked repo with a tag like "v0.0.1"
- Wait for github action to finish
- Use your new generated container image to deploy.

### Deploy to fly.io
- Install [flyctl](https://fly.io/docs/flyctl/installing/)
- git clone repo and change path to repo folder
```
# Login
flyctl auth login
# Create app
flyctl apps create <app_name>
# Set region https://fly.io/docs/reference/regions/
flyctl regions set <region_code> -a <app_name>
# Create persistent storage volume. You can skip this step if you are going to set a database URI.
flyctl volumes create vaultwarden <region_code> -a <app_name> --size 1
```
- edit fly.toml to set envs
```
# Deploy
flyctl deploy --detach -a <app_name> --remote-only
# If you have trouble with connection, enable websocket mode
flyctl wireguard websockets enable
```
