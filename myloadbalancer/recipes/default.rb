#
# Cookbook Name:: myloadbalancer
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
package 'haproxy' do
  action :install
end

service 'haproxy' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

template '/etc/haproxy/haproxy.cfg' do
  source 'haproxy.cfg.erb'
  mode 775
  owner 'root'
  action :create
  notifies :restart, 'service[haproxy]', :immediately
end
