#
# Cookbook:: lamp
# Recipe:: apache
#
# Copyright:: 2019, The Authors, All Rights Reserved.
apt_package 'apache2' do
  action :install
end

template "/etc/apache2/sites-available/#{node['apache']['site_name']}.conf" do
  source 'vhosts.erb'
  variables(
    :port_no => node['apache']['port_no'],
    :document_root => node['apache']['document_root'],
    :site_name =>  node['apache']['site_name'],
  )
not_if {::File.exist?("/etc/apache2/sites-available/#{node['apache']['site_name']}.conf") }
end

bash 'adding_sites_to_apache' do
    code <<-EOH
    cd /etc/apache2/sites-available
    sudo a2ensite "#{node['apache']['site_name']}.conf"
    EOH
not_if {::File.exist?("/etc/apache2/sites-enabled/#{node['apache']['site_name']}.conf")}
end

ruby_block "Addding Ports to Ports conf" do
  block do
   fe=Chef::Util::FileEdit.new("/etc/apache2/ports.conf")
   fe.insert_line_after_match("Listen 80","Listen #{node['apache']['port_no']}")
   fe.write_file
end
not_if{node['apache']['initial'] }
end

ruby_block "port_are_added_only_once" do
block do
  node.normal["apache"]["initial"]=true
end
end
service "apache2" do
  action [:enable, :start]
end

