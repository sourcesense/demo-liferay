#
# Cookbook Name:: sourcesense_mysql
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
remote_file '/tmp/mysql-community-release-el7-5.noarch.rpm' do
  source 'http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm'
  notifies :run, 'execute[install_rpm]', :immediately
  not_if 'rpm -qa | grep mysql-community'
end

execute 'install_rpm' do
  command 'rpm -ivh /tmp/mysql-community-release-el7-5.noarch.rpm'
  action :nothing
end

['mysql-community-devel', 'mysql-community-libs'].each do |p|
  package p
end

mysql_service 'liferay' do
  bind_address '0.0.0.0'
  port '3306'
  initial_root_password 'password'
  action [:create, :start]
end

mysql_connection_info = {
  host: '127.0.0.1',
  username: 'root',
  password: 'password'
}

mysql2_chef_gem 'default' do
  action :install
end

mysql_database node['sourcesense_mysql']['database'] do
  connection mysql_connection_info
  action :create
end

database_user node['sourcesense_mysql']['dbuser'] do
  connection mysql_connection_info
  password   'password'
  provider   Chef::Provider::Database::MysqlUser
  action     :create
end

mysql_database_user node['sourcesense_mysql']['dbuser'] do
  connection    mysql_connection_info
  password      node['sourcesense_mysql']['dbpassword']
  database_name node['sourcesense_mysql']['database']
  host          '%'
  privileges    [:all]
  action        :grant
end


execute "erasedb" do
  command "sleep 5 && mysql -h 127.0.0.1 -u root -ppassword -e \"drop database lportalCluster; create database lportalCluster\""
end
