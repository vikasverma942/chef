#
# Cookbook:: lamp
# Recipe:: mysql
#
# Copyright:: 2019, The Authors, All Rights Reserved.
data=data_bag_item('data_bag','dataone')
bash 'Install_Mysql_server' do
    code <<-EOH
    sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password #{data['rootpass']}'
    sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password #{data['rootpass']}'
    sudo apt-get -y install mysql-server
    EOH
    not_if { ::Dir.exist?("/var/lib/mysql") }
end
