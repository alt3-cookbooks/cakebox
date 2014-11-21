
# Cakebox
default['cakebox']['apps_dir']     = '/home/vagrant/Apps'
default['cakebox']['removable_files'] = [
  '/home/vagrant/install.sh' # Chef left-over in vagrant home
  ]

# Default website
default['cakebox']['nginx']['catchall_source'] = 'nginx-catchall.erb'
default['cakebox']['nginx']['catchall_webroot'] = '/cakebox/catchall'

# FriendsOfCake
default['cakebox']['foc']['app_template_file_cache_dir'] = '/var/log/app'

# Motd banner
default['cakebox']['motd']['message_dir'] = '/etc/update-motd.d'
default['cakebox']['motd']['banner_source'] = 'motd-banner.erb'
default['cakebox']['motd']['banner_target'] = '20-cakebox-banner'
default['cakebox']['motd']['removables'] = [
    '10-help-text',
    '90-updates-available'
]
