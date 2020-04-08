#!/usr/bin/env bash

set -ex

if [ "$PORTUS_CI" = "unit" ] || [ "$PORTUS_CI" = "all" ]; then
  # Use the latest stable Node.js. We disable -x because the output gets really
  # ugly otherwise.
  set +x
  source ~/.nvm/nvm.sh
  nvm install 10.19.0
  nvm use 10.19.0
  set -x

  # Install Yarn
  sudo rm $(which yarn)
  npm install -g yarn@1.22.4

  # Intall Go, which is needed for git-validation
  eval "$(curl -sL https://raw.githubusercontent.com/travis-ci/gimme/master/gimme | GIMME_GO_VERSION=1.10.2 bash)"
  go get -u github.com/vbatts/git-validation
fi

if [ "$PORTUS_CI" = "integration" ] || [ "$PORTUS_CI" = "all" ]; then
  # Install bats.
  git clone https://github.com/sstephenson/bats.git
  cd bats
  sudo ./install.sh /usr/local
  cd .. && rm -rf bats
fi

# Install ruby gems.
bundle install --jobs=3 --retry=3

# Update the Chrome driver, needed for feature tests.
RAILS_ENV=test bin/rails webdrivers:chromedriver:update
