#
# Cookbook Name:: myloadbalancer
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

node.set['haproxy']['members'] = node['myloadbalancer']['liferay_backends']

include_recipe 'haproxy'
