
# Cakebox
default['cakebox']['apps_dir']     = '/home/vagrant/Apps'
default['cakebox']['removable_files'] = [
  '/home/vagrant/install.sh' # Chef left-over in vagrant home
]

# SSH
default['cakebox']['ssh']['config_source'] = 'sshd_config.erb'
default['cakebox']['ssh']['config_target'] = '/etc/ssh/sshd_config'
default['cakebox']['ssh']['known_hosts'] = [
  'github.com',
  'heroku.com'
]

# Database settings
default['cakebox']['databases']['remote_username'] = 'vagrant'
default['cakebox']['databases']['remote_password'] = 'vagrant'

# Nginx: default site template, SSL certificates and test-kitchen catchall html
default['cakebox']['nginx']['default_site'] = 'nginx-default-site.erb'
default['cakebox']['nginx']['catchall_sources'] = 'catchall'
default['cakebox']['nginx']['catchall_webroot'] = '/cakebox/console/webroot'
default['cakebox']['nginx']['certs_dir'] = '/etc/nginx/ssl'
default['cakebox']['nginx']['conf_source'] = 'nginx.conf.erb'
default['cakebox']['nginx']['conf_target'] = '/etc/nginx/nginx.conf'

# Logstash
default['cakebox']['logstash']['pattern_nginx_source'] = 'logstash_pattern_nginx.erb'
default['cakebox']['logstash']['pattern_nginx_target'] = '/opt/logstash/server/patterns/nginx'
default['cakebox']['logstash']['config_nginx_source'] = 'logstash_config_nginx.erb'
default['cakebox']['logstash']['config_nginx_target'] = '/opt/logstash/server/etc/conf.d/nginx.conf'
default['cakebox']['logstash']['logdir_owners'] = {
  'nginx' => 'root',
  'mysql' => 'mysql',
  'redis' => 'redis',
  'postgresql' => 'postgres'
}

# Kibana
default['cakebox']['kibana']['config_source'] = 'kibana.yml.erb'
default['cakebox']['kibana']['config_target'] = '/opt/kibana/current/config/kibana.yml'

# FriendsOfCake
default['cakebox']['foc']['app_template_file_cache_dir'] = '/var/log/app'

# Motd banner
default['cakebox']['motd']['message_dir'] = '/etc/update-motd.d'
default['cakebox']['motd']['banner_source'] = 'motd-banner.erb'
default['cakebox']['motd']['banner_target'] = '20-cakebox-banner'
default['cakebox']['motd']['removable_messages'] = [
  '10-help-text',
  '90-updates-available'
]

# Sudoers file
default['cakebox']['sudoers']['source'] = 'sudoers.erb'
default['cakebox']['sudoers']['target'] = '/etc/sudoers'
