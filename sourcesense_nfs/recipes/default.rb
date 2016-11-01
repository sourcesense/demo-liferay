#
# Cookbook Name:: sourcesense_nfs
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
directory '/data' do
  action :create
end

nfs_export '/data' do
  network '0.0.0.0/8'
  writeable false
  sync true
  options ['no_root_squash']
end
