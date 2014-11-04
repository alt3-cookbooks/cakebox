# Exit on Windows platforms
return if node['platform'] == 'windows'

# Nginx: define cb service so we can use it to reload
service "nginx" do
  supports :status => true, :restart => true, :reload => true
end

# Nginx: create default site directory
directory "Nginx: default site directory" do
  path node['cakebox']['nginx']['html_target']
  owner 'vagrant'
  group 'vagrant'
  mode '0777'
  recursive true
  action :create
end

# Nginx: copy each cbf (cookbookfile) from /files/website/ to the default site directory
cb = run_context.cookbook_collection[cookbook_name]
cb.manifest['files'].each do |cbf|
  if cbf['path'].start_with?( "files/default/#{node['cakebox']['nginx']['html_source']}" )
    cookbook_file "#{node['cakebox']['nginx']['html_target']}/#{cbf['name']}" do
      source "#{node['cakebox']['nginx']['html_source']}/#{cbf['name']}"
    end
  end
end

# Nginx: create and load default site configuration file
template "Nginx: default site configuration" do
  path "/etc/nginx/sites-available/default"
  source "nginx-default.erb"
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
