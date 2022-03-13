# minecraft-server
Dockerised Minecraft server compose stack

## Features
- [Paper](https://papermc.io/) server
- [Velocity](https://docs.papermc.io/velocity) proxy
- SQL DB and Redis for syncing [LuckPerms](https://luckperms.net/wiki/Home) permissions

Paper and Velocity are downloaded automatically when building the docker images. Plugins like LuckPerms must be added manually.

Other servers and proxies can probaably be used, but Paper and Velocity are what I am using.

## Usage

Create a `.env` file, defining the variables given in the [example](./.env.example).

Build and run the stack:
```shell
docker-compose build && docker-compose up -d
```

### Configuration

More configuration is needed to actually make the server accessible. See the [Velocity documentation](https://velocitypowered.com/wiki/users/getting-started/) for how to do this.

The jars for plugins, like LuckPerms, will need to be downloaded and added to the plugins directories for the servers and proxy manually.

See the [LuckPerms documentation](https://luckperms.net/wiki/Syncing-data-between-servers) if you want to use the MariaDB database and redis to sync permissions across worlds and the proxy.

**Note:** The address of your servers, databases *etc.* will be their compose service-names, *e.g.* `world1:25565` for the server in this example.


### Running server commands

As `stdin` is open on the proxy and server containers, you can attach to the container and run commands:

```shell
docker attach --sig-proxy=false container_name
```

**Note:** Make sure to disable the signal proxy, otherwise `ctrl-c` will stop the container, rather than leave the container.

## Environment variables
These are environment variables used as build args for images, or the docker-compose configuration.

|Variable|Description|Default|
|-|-|-|
|PID|User ID of the user running the container entrypoint. The container's `/srv` directory will be owned by this user|`911`|
|PGID|Primary group ID of the user above.|`911`|
|MARIADB_ROOT_PASSWORD|[See official docs](https://github.com/docker-library/docs/blob/master/mariadb/README.md#environment-variables)||
|MARIADB_USER|[See official docs](https://github.com/docker-library/docs/blob/master/mariadb/README.md#environment-variables)||
|MARIADB_PASSWORD|[See official docs](https://github.com/docker-library/docs/blob/master/mariadb/README.md#environment-variables)||
|MARIADB_DATABASE|[See official docs](https://github.com/docker-library/docs/blob/master/mariadb/README.md#environment-variables) - note that LuckPerms expects a database named 'minecraft', so this is a useful default to use||
|SRV_DIR|Top-level directory of the stack. This is just used for the bind-mounts in the [compose file](./docker-compose.yml), so can be removed||
|SERVER_URL|The URL to download the server jar file from. See [here](https://papermc.io/downloads#Paper-1.18) for paper build downloads|
|VELOCITY_URL|The URL to download the proxy jar file from. See [here](https://papermc.io/downloads#Velocity) for velocity build downloads|

