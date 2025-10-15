#!/bin/bash

set -e

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEST_DIR="$(pwd)"

# When running under cvise, symlink everything needed to bundle and test
# to the temporary target directory
if [[ "$SOURCE_DIR" != "$TEST_DIR" ]]; then
    ln -sf "$SOURCE_DIR"/node_modules "$TEST_DIR"/node_modules
    ln -sf "$SOURCE_DIR"/package.json "$TEST_DIR"/package.json
    ln -sf "$SOURCE_DIR"/run-playwright.js "$TEST_DIR"/run-playwright.js
    ln -sf "$SOURCE_DIR"/index.html "$TEST_DIR"/index.html
fi

# An interesting test case is when the non-minified version works (no output),
# but the minified version fails with "c is not defined".

./node_modules/.bin/rolldown index.js --file bundle.js
OUT1=$(nodejs run-playwright.js 2>&1)

# Bail out, not interesting
if [[ "$OUT1" != "" ]]; then
    exit 1
fi

./node_modules/.bin/rolldown index.js --file bundle.js --minify
OUT2=$(nodejs run-playwright.js 2>&1)

# Bail out, not interesting
if [[ "$OUT2" != "c is not defined" ]]; then
    exit 1
fi

# Interesting case, report success
exit 0
