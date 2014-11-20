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
node['cakebox']['remove_files'].each do |filepath|
  file filepath do
    action :delete
  end
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

# Nginx: define a cookbook service for nginx so we can reload the server
service "nginx" do
  supports :status => true, :restart => true, :reload => true
end

# Nginx: create  default site/catchall directory
directory "Nginx: default site directory" do
  path node['cakebox']['nginx']['catchall_root']
  owner 'vagrant'
  group 'vagrant'
  mode '0777'
  recursive true
  action :create
end

# Nginx: copy each cbf (cookbookfile) from /files/website/ to the default site directory
cb = run_context.cookbook_collection[cookbook_name]
cb.manifest['files'].each do |cbf|
  if cbf['path'].start_with?( "files/default/#{node['cakebox']['nginx']['catchall_source']}" )
    cookbook_file "#{node['cakebox']['nginx']['catchall_root']}/#{cbf['name']}" do
      source "#{node['cakebox']['nginx']['catchall_source']}/#{cbf['name']}"
    end
  end
end

# Nginx: create and load default site configuration file
template "Nginx: default site configuration" do
  path "/etc/nginx/sites-available/default"
  source "nginx-default.erb"
  variables(
    :root => node['cakebox']['nginx']['catchall_root']
   )
  notifies :reload, "service[nginx]", :immediately
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

# Cake: Install acl so users can use setfacl to set permissions as described in The Book
package 'acl' do
  action :install
end
