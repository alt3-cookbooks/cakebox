# cakebox cookbook

[![Build Status](https://travis-ci.org/alt3-cookbooks/cakebox.svg)](https://travis-ci.org/alt3-cookbooks/cakebox)

Cookbook used to configure the [Cakebox](https://github.com/alt3/cakebox).

# Supported Platforms

This cookbook is test-kitchen tested against the following platforms:

- ubuntu-14.04

# Depends

- phplipper [chef-nginx](https://github.com/phlipper/chef-nginx) cookbook

# Recipes

## cakebox::default

- Installs the Cakebox website
- Creates /var/log/app to support FriendsOfCake [app-template](https://github.com/FriendsOfCake/app-template) file caching on Vagrant
- Installs acl so users can use setfacl to set permissions as described in [The Book](http://book.cakephp.org/2.0/en/installation.html#permissions)

# Contributing

1. Fork it ( https://github.com/alt3-cookbooks/cakebox/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Make sure test-kitchen and foodcritic tests pass
4. Commit your changes (`git commit -am 'Adds some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

# TODO

- new: use Cake theme for default site
- bug: disable motd login message
- new: add ASCII login logo, maybe add custom information: ip-addresses, databases, websites

#               !!!!  UPLOAD CAKEBOX.BOX  !!!!
