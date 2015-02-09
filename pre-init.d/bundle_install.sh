#!/bin/bash

set -e

if [ -f /home/arunner/executor/Gemfile ]; then
    pushd /home/arunner
    cp executor/Gemfile executor/Gemfile.lock .
    # Install gem deps here: /home/arunner/vendor/bundle/ruby/2.2.0
    bundle install --deployment
    popd
fi