# About this example

This example runs Portus using PostgreSQL instead of MySQL. This is achieved
through environment variables. In particular:

- You have to set `PORTUS_DB_GEM` to `pg`, so this gem is installed. Moreover,
  you need to set `PORTUS_RUN_BUNDLER` so the `init` command runs `bundle`
  before doing anything at all.
- You have to set `PORTUS_DB_ADAPTER` to `postgresql` so this RDBMS is picked
  instead of the default MYSQL adapter.
- We have changed the `PORTUS_DB_USERNAME` to `postgres` instead of leaving the
  default value, since PostgreSQL's default user is `postgres` and not `root`.

## How to run this example

This example is similar to the `docker-compose.yml` file from the root of the
project, but using PostgreSQL. If you want to use it, perform the following
commands (from the root of the project):

```
$ cp examples/postgresql/docker-compose.yml docker-compose.postgres.yml
$ docker-compose -f docker-compose.postgres.yml up
```

## Tips for production

If you want to run PostgreSQL and Portus in production, having to call `bundle`
when bringing up the containers is a bad idea. Instead, create a new Docker
image that derives from the [official Portus image](https://github.com/openSUSE/docker-containers/tree/master/derived_images/portus) and install the `pg` gem
there.
