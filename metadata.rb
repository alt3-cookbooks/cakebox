name             'cakebox'
maintainer       'alt3.io'
license          'MIT'
description      'Chef cookbook used to configure the Cakebox'
version          '1.0.0'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

depends  "apt"
depends  "ssh_known_hosts"
depends  "git-ppa"
depends  "percona"
depends  "php5-ppa"
depends  "nginx"
depends  "composer"
depends  "phpcs"

supports "ubuntu"
