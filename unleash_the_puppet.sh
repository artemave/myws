#!/bin/sh

if [ ! command -v ruby &>/dev/null ]; then
  echo "ruby must present"
  exit 1
fi

gem install bundler
bundle install

echo N | puppet-module install puppetlabs-vcsrepo
echo N | puppet-module install kelseyhightower-homebrew

puppet apply --modulepath=./ myws.rb
