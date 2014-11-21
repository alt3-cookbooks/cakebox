# Exit on Windows platforms
return if node['platform'] == 'windows'

# Cakebox: pre-create /var/home/vagrant/Apps with 0777 to prevent Synced Folders
# mounted to a subfolder will create the folder itself using too restrictive
# permissions.
directory "Cakebox: Apps" do
  path node['cakebox']['apps_dir']
  owner 'vagrant'
  group 'vagrant'
  mode '0777'
  action :create
end

# Cakebox: clean up system by removing all files specified in atrributes
node['cakebox']['removable_files'].each do |filepath|
  file filepath do
    action :delete
  end
end

# MySQL: grant remote access to vagrant user
execute "Grant vagrant user remote MySQL access" do
    username = node['cakebox']['databases']['remote_username']
    password = node['cakebox']['databases']['remote_password']
    rootpass = node["percona"]["server"]["root_password"]
    command "/usr/bin/mysql -u root -p#{rootpass} -e \"GRANT ALL PRIVILEGES ON *.* TO '#{username}'@'%' IDENTIFIED BY '#{password}' WITH GRANT OPTION;\""
    action :run
end

# Nginx: define an nginx cookbook service so we can use it to manipulate the real service
service "nginx" do
  supports :status => true, :restart => true, :reload => true
end

# Nginx: create  default site/catchall directory
directory "Nginx: default site directory" do
  path node['cakebox']['nginx']['catchall_webroot']
  owner 'vagrant'
  group 'vagrant'
  mode '0777'
  recursive true
  action :create
end

# Nginx: copy each cbf (cookbookfile) from /files/website/ to the default site directory
cb = run_context.cookbook_collection[cookbook_name]
cb.manifest['files'].each do |cbf|
  cookbook_file "#{node['cakebox']['nginx']['catchall_webroot']}/#{cbf['name']}" do
    source "#{node['cakebox']['nginx']['catchall_sources']}/#{cbf['name']}"
    only_if { cbf['path'].start_with?( "files/default/#{node['cakebox']['nginx']['catchall_sources']}" ) }
  end
end

# Nginx: create and load default site configuration file
template "Nginx: default site configuration" do
  source node['cakebox']['nginx']['default_site']
  path "/etc/nginx/sites-available/default"
  variables(
    :root => node['cakebox']['nginx']['catchall_webroot']
   )
  notifies :reload, "service[nginx]", :immediately
end

# PHPCS: set CakePHP as the default standard globally
execute "Make CakePHP the default PHPCS coding standard" do
    command "phpcs --config-set default_standard CakePHP"
    action :run
end

# PHPCS: show progress without -p parameter
execute "Always show PHPCS progress" do
    command "phpcs --config-set show_progress 1"
    action :run
end

# CakePHP: Install acl so users can use setfacl to set permissions as described in The Book
package 'acl' do
  action :install
end

# FriendsOfCake: app-template uses /var/log/app for file based caching
# and expects the directory to be present.
directory "Foc: app-template file cache" do
    path node['cakebox']['foc']['app_template_file_cache_dir']
    owner 'vagrant'
    group 'vagrant'
    mode '0777'
    action :create
end

# MOTD: remove annoying update-notifier and other noisifying/useless messages
node['cakebox']['motd']['removable_messages'].each do |removable|
  file "MOTD: delete noise" do
    path "#{node['cakebox']['motd']['message_dir']}/#{removable}"
    action :delete
  end
end

# MOTD: create executable cakebox banner bash file
template "MOTD: cakebox banner" do
    source node['cakebox']['motd']['banner_source']
    path "#{node['cakebox']['motd']['message_dir']}/#{node['cakebox']['motd']['banner_target']}"
    mode '0755'
end

# MOTD: update dynamic message so it is up-to-date at initial login
execute "MOTD: update dynamic message" do
    command "run-parts /etc/update-motd.d/ | tee /run/motd.dynamic"
    action :run
end
