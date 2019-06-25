#
# Cookbook:: lamp
# Recipe:: codedeploy
#
# Copyright:: 2019, The Authors, All Rights Reserved.
datas=data_bag_item('data_bag','dataone')
bash 'database_setup' do
    code <<-EOH
    sudo cp -R #{datas['source']} #{datas['dest']}
    EOH
 not_if { ::Dir.exist?("/home/ubuntu/PHP") }
end
