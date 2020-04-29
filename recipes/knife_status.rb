#
# Cookbook:: motd
# Recipe:: knife_status
#
# Copyright:: 2012, Chris Aumann
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

# We need to current interval in minutes
interval = Integer(interval) / 60

# As the same with interval, get the current configured interval splay.
splay = Chef::Config[:splay]
splay ||= node['chef_client']['splay'] if node.attribute?('chef_client')
splay ||= 300
# We need to current splay in minutes
splay = Integer(splay) / 60

timestamp_file = "#{Chef::Config[:file_cache_path]}/last_successful_chef_run"

motd '98-knife-status' do
  source 'knife_status.sh.erb'
  variables(
    maxium_delay: interval + splay,
    timestamp_file: timestamp_file
  )
  only_if { ::File.directory? '/etc/update-motd.d' }
end

Chef.event_handler do
  on :run_completed do
    File.open(timestamp_file, 'w') do |file|
      file.write Time.now.to_i
    end
  end
end
