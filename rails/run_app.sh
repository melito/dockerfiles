#!/bin/bash
 
source /setup.sh
source /etc/profile.d/rbenv.sh
 
git clone $GIT_URL /app
 
cp /puma.rb /app/config
mkdir -p /app/shared/tmp/sockets
mkdir -p /app/shared/tmp/pids
 
rbenv rehash
cd /app && gem install bundler
cd /app && bundle install
cd /app && bundle exec rake db:migrate
cd /app && bundle exec puma -q -e $RAILS_ENV -C /app/config/puma.rb
