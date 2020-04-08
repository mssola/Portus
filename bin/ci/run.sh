#!/usr/bin/env bash

set -ex

##
# Auxiliar functions

PORTUS_DB_ADAPTER=${PORTUS_DB_ADAPTER:-mysql2}

# Interacts with a daemon by taking two arguments:
#   1. The action (e.g. "start").
#   2. The service (e.g. "mysql").
# We do this to abstract the fact that Travis CI does not use systemd and we do.
function __daemon() {
    if [[ -z "$CI" ]]; then
        sudo systemctl "$1" "$2"
    else
        sudo service "$2" "$1"
    fi
}

# Performs systemctl calls to the current database adapter when used outside of
# a container.
function __database() {
    if [[ -f /.dockerenv ]]; then
        return
    fi

    if [[ "$PORTUS_DB_ADAPTER" == "mysql2" ]]; then
        __daemon "$1" mysql
    else
        __daemon "$1" postgresql
    fi
}

# Setup an insecure registry for the local docker.
function __docker_insecure() {
    if [[ -n "$CI" ]]; then
        sudo tee /etc/docker/daemon.json > /dev/null <<EOF
{
  "insecure-registries" : ["172.17.0.1:5000"]
}
EOF
    fi
    __daemon restart docker

    # Show version info
    docker --version
    docker-compose --version
}

if [ -z "$PORTUS_CI" ]; then
    echo "You have to set the PORTUS_CI environment variable."
    echo "Available values: unit and integration."
    exit 1
fi

##
# The actual run

if [ "$PORTUS_CI" = "unit" ] || [ "$PORTUS_CI" = "all" ]; then
    # Run zeitwerk:check to check whether Rails can eager load the whole
    # application (thus ensuring that there are no loading surprises).
    #
    # Furthermore, it may happen that the check exited with an exit code that is
    # not zero but it's still not perfect (a warning). Let's fail on that too.
    out=$(bundle exec bin/rails zeitwerk:check | tail -n1)
    if [ "$out" != "All is good!" ]; then
        echo "Zeitwerk is failing. Running again to see the output:"
        bundle exec bin/rails zeitwerk:check
        exit 1
    fi

    # Test commit messages
    bundle exec rake git-validation

    # Style and security checks
    bundle exec rubocop -V
    bundle exec rake rubocop

    # Check that MySQL and PostgreSQL have the same schema version
    bundle exec rails r bin/schema_check.rb

    # Compile assets
    NODE_ENV=development bundle exec rake webpacker:compile

    # Ruby tests
    __database restart
    bundle exec rspec spec

    # Note: it ignores a couple of files which use ruby 2.5 syntax which brakeman
    # does not know how to handle...
    bundle exec brakeman --skip-files lib/portus/background/sync.rb,lib/portus/registry_client.rb

    # JavaScript tests and style.
    yarn test
    yarn eslint
fi

# Integration tests.
if [ "$PORTUS_CI" = "integration" ] || [ "$PORTUS_CI" = "all" ]; then
    if [[ ! -f /.dockerenv ]]; then
        __docker_insecure
        bundle exec rake test:run
    fi
fi
