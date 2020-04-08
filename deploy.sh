#!/bin/bash
set -o pipefail
set -eu

# Prepare git for pushing version bump to
git config --global user.name "Karl Falconer"
git config --global user.email karl@falconerdevelopment.com
git config --global push.default current

# configure geminabox to use private gem server
echo -e "---\n:host: http://x:${GEM_PASSWORD}@gems.falconerdevelopment.com" > ~/.gem/geminabox

# release gem
bundle exec rake build
bundle exec gem inabox pkg/*.gem
echo "Deployment complete"
