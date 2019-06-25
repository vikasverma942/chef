#
# Cookbook:: lamp
# Recipe:: database
#
# Copyright:: 2019, The Authors, All Rights Reserved.

datas=data_bag_item('data_bag','dataone')
if !node["database"]["initial"]
bash 'database_setup' do
    code <<-EOH
    mysql -u "root" -p"#{datas['rootpass']}" -e "CREATE DATABASE #{datas['dbname']}"
    mysql -u "root" -p"#{datas['rootpass']}" -e "CREATE USER '#{datas['user']}'@'localhost' IDENTIFIED BY '#{datas['userpass']}'"
    mysql -u "root" -p"#{datas['rootpass']}" -e "GRANT ALL PRIVILEGES ON #{datas['dbname']}.* TO '#{datas['user']}'@'localhost'"
    mysql -u "root" -p"#{datas['rootpass']}" #{datas['dbname']} <  #{datas['query']}
    EOH
end
end

ruby_block "database_scripts_will_run_only_once" do
 block do
  node.normal["database"]["initial"]=true
end
end
