#!/bin/bash

# This runs as root on the server

# Need to install chef on remove server
# sudo true && curl -L https://www.opscode.com/chef/install.sh | sudo bash
# disable SELinux

chef-solo -c solo.rb -j solo.json
