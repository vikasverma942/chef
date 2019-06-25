#
# Cookbook:: lamp
# Recipe:: php
#
# Copyright:: 2019, The Authors, All Rights Reserved.
apt_package 'php' do
  action :install
end
apt_package 'libapache2-mod-php' do
  action :install
end
apt_package 'php-mysql' do
  action :install
end
apt_package 'php-curl' do
  action :install
end
apt_package 'php-xml' do
  action :install
end
apt_package 'php-memcached' do
  action :install
end
service "apache2" do
 action :restart
end

