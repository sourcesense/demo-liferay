#
# Cookbook Name:: sourcesense_liferay
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
user 'liferay' do
  home '/home/liferay'
  shell '/bin/bash'
end

directory '/home/liferay/.ssh' do
  owner 'liferay'
  mode 600
end

['authorized_keys',
 'id_rsa',
 'id_rsa.pub'].each do |k|
  cookbook_file "/home/liferay/.ssh/#{k}" do
    source "INSECURE_KEYS/#{K}"
    mode 600
  end
end

group 'liferay'

package %w(unzip rsync)

selinux_state 'SELinux Permissive' do
  action :permissive
end

mount '/data' do
  device node['sourcesense_liferay']['data_nfs']
  fstype 'nfs'
  options 'rw'
  action [:mount, :enable]
end

cookbook_file File.join('/opt', node['sourcesense_liferay']['bundle']) do
  owner 'liferay'
  group 'liferay'
  source node['sourcesense_liferay']['bundle']
  action :create_if_missing
end

ark 'liferay' do
  path '/opt'
  url "file://#{File.join('/opt', node['sourcesense_liferay']['bundle'])}"
  checksum node['sourcesense_liferay']['checksum']
  action :put
  backup false
end

link node['sourcesense_liferay']['lf_home'] do
  to "/opt/#{node['sourcesense_liferay']['bundle']}"
end

directory File.join(node['sourcesense_liferay']['lf_home'], 'deploy') do
  owner 'liferay'
  group 'liferay'
  mode 775
end

directory File.join(node['sourcesense_liferay']['lf_home'], 'cluster_deploy') do
  owner 'liferay'
  group 'liferay'
  mode 775
end

directory File.join(node['sourcesense_liferay']['lf_home'], 'cluster_deploy', 'deploy') do
  owner 'liferay'
  group 'liferay'
  mode 775
end

cookbook_file File.join(node['sourcesense_liferay']['lf_home'], 'activation-key-development-6.2ee-Sourcense.xml') do
  source 'activation-key-development-6.2ee-Sourcense.xml'
  owner 'liferay'
  grpup 'liferay'
end

execute 'StartLiferay' do
  command './startup.sh'
  cwd File.join(node['sourcesense_liferay']['lf_home'], 'tomcat-7.0.62', 'bin')
end
