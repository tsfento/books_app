#!/usr/bin/env bash
set -o errexit
bundle install
bundle exec rake db:migrate
# chmod u+x bin/rails 
# #not sure if line 5 goes here