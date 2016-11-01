#
# Cookbook Name:: sourcesense_nfs
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

selinux_state 'SELinux Permissive' do
  action :permissive
end

directory '/data' do
  action :create
end

nfs_export '/data' do
  network '192.168.56.0/24'
  writeable true
  sync true
  options ['no_root_squash']
end
