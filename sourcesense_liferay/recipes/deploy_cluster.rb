#
# Cookbook Name:: sourcesense_liferay
# Recipe:: deploy
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


cookbook_file "#{node['sourcesense_liferay']['lf_home']}/cluster_deploy/cluster_deploy.sh" do
  source 'cluster_deploy.sh'
  owner 'liferay'
  group 'liferay'
  mode  '775'
end
