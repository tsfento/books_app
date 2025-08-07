#!/usr/bin/env bash
set -o errexit
bundle install
bundle exec rake db:migrate
# chmod +x bin/render-build.sh 
# #not sure if line 5 goes here