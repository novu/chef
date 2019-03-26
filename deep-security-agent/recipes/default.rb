#
# Cookbook Name:: deep-security-agent
# Recipe:: Deploy the Deep Security agent
#
# Copyright 2015, Trend Micro
#
# License as per [repo](master/LICENSE)
#
# *********************************************************************
# * Install the Deep Security Agent
# *********************************************************************

if node['ec2'] && node['ec2']['instance_type'] != 't2.small' && node['deep_security_agent']['action'] == 'install'
  include_recipe 'deep-security-agent::dsa-install'
  include_recipe 'deep-security-agent::dsa-activate'
end

if node['deep_security_agent']['action'] == 'uninstall'
  if node['platform'] == 'amazon'
    execute 'ds-agent uninstall' do
      command 'sudo rpm -ev ds_agent'
      only_if 'sudo yum list installed |grep ds_agent'
    end
  if node['platform'] == 'ubuntu'
    execute 'ds-agent uninstall' do
      command 'sudo dpkg -r ds-agent'
      only_if 'sudo dpkg -l ds-agent'
    end
end
