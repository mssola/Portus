#!/usr/bin/env bash

set -ex

if [ "$PORTUS_CI" = "unit" ] || [ "$PORTUS_CI" = "all" ]; then
    # Having multiple reports might confuse Code Climate, let's make sure that
    # only one runner actually sends the test report. This should be safe since
    # workers from unit tests run the same test suite.
    if [ "$PORTUS_DB_ADAPTER" = "postgresql" ]; then
        ./cc-test-reporter after-build --exit-code "$TRAVIS_TEST_RESULT"
    fi
fi
