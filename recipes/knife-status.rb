#
# Cookbook Name:: motd
# Recipe:: default
#
# Copyright 2012, Chris Aumann
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# Chef::Config[:interval] somehow is nil, therefore falling back to
# configuration of chef_client cookbook (if available)
# and finally the chef default of 1800s
interval = Chef::Config[:interval]
interval ||= node['chef_client']['interval'] if node.attribute?('chef_client')
interval ||= 1800

motd '98-knife-status' do
  source    'knife-status.erb'
  variables interval: interval,
            timestamp_file: "#{Chef::Config[:file_cache_path]}/last_successful_chef_run"

  only_if { ::File.directory? '/etc/update-motd.d' }
end

# add a chef-handler that creates a file with the current timestamp on a successful chef-run
directory '/var/chef/handlers' do
  mode 00755
end

template '/var/chef/handlers/knife_status.rb' do
  mode   00644
  source 'knife-status-handler.rb'
end

chef_handler 'Motd::KnifeStatus' do
  source '/var/chef/handlers/knife_status.rb'
  action :enable
end
