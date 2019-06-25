#
# Cookbook:: lamp
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
#Updates Package Manager
execute 'apt-get-update' do
  command 'sudo apt-get update -y'
end

