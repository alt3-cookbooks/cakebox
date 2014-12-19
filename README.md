# cakebox cookbook

[![Build Status](https://travis-ci.org/alt3/chef-cakebox.svg)](https://travis-ci.org/alt3/chef-cakebox)

Cookbook used for [Cakebox](https://github.com/alt3/cakebox) customizations.

# Supported Platforms

This cookbook is kitchen-tested against the following platforms:

- ubuntu-14.04

# Specifications

- **Attributes**: see [attributes/default.rb](https://github.com/alt3/chef-cakebox/blob/master/attributes/default.rb)
- **Dependencies**: see [Berksfile](https://github.com/alt3/chef-cakebox/blob/master/Berksfile)

# Recipes

## cakebox::default

See recipe for full details:

- Configures SSL/https for catchall website
- Disables SSH username/password logins
- Pre-configures known_hosts
- Creates and configures ~/Apps directory for vagrant user
- Sets CakePHP as the default PHPCS coding standard
- Creates /var/log/app to support FriendsOfCake [app-template](https://github.com/FriendsOfCake/app-template) file caching on Vagrant
- Installs acl so users can use setfacl to set permissions as described in [The Book](http://book.cakephp.org/2.0/en/installation.html#permissions)

# Test-kitchen

	cd chef-cakebox
	kitchen create
	kitchen verify

# Contributing

1. Fork it ( https://github.com/alt3/chef-cakebox/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Make sure test-kitchen and foodcritic tests pass
4. Commit your changes (`git commit -am 'Adds some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request
