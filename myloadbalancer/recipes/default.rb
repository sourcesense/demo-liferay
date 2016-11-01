#
# Cookbook Name:: myloadbalancer
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

node.set['haproxy']['members'] = [{
  "hostname" => "liferaynode01",
  "ipaddress" => "192.168.1.4",
  "port" => 8080
}, {
  "hostname" => "liferaynode02",
  "ipaddress" => "192.168.1.4",
  "port" => 8080
}]

include_recipe 'haproxy'
