
# Cakebox
default['cakebox']['apps_dir']     = '/home/vagrant/Apps'
default['cakebox']['remove_files'] = [
  '/home/vagrant/install.sh' # Chef left-over in vagrant home
  ]

# Default website
default['cakebox']['nginx']['catchall_source'] = 'catchall'
default['cakebox']['nginx']['catchall_root'] = '/cakebox/catchall'

# FriendsOfCake
default['cakebox']['foc']['app_template_file_cache_dir'] = '/var/log/app'
