#
# Cookbook Name:: sourcesense_liferay
# Recipe:: deploy
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

cookbook_file "#{node['sourcesense_liferay']['lf_home']}/deploy/Bootcamp2016-portlet-6.2.0.1.war" do
  source 'Bootcamp2016-portlet-6.2.0.1.war'
  owner 'liferay'
  group 'liferay'
end

cookbook_file "#{node['sourcesense_liferay']['lf_home']}/cluster_deploy/cluster_deploy.sh" do
  source 'cluster_deploy.sh'
  owner 'liferay'
  group 'liferay'
  mode  '775'
end
