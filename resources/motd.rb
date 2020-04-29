#
# Cookbook:: motd
# Resource:: default
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

resource_name :motd

default_action :create

property :cookbook, String, default: 'motd'
property :source, String, default: 'cow.erb'
property :variables, Hash, default: {}
property :color, [true, false], default: node['motd']['color']

action :create do
  # is this machine using update-motd?
  update_motd = ::File.directory? '/etc/update-motd.d'

  # default variables
  default_variables = {
    update_motd: update_motd,
    environment: node.chef_environment,
    domain: node['domain'],
    hostname: node['hostname'],
    color: new_resource.color,
  }

  if update_motd
    target = "/etc/update-motd.d/#{new_resource.name}"
    permissions = '0755'
  else
    target = '/etc/motd'
    permissions = '0644'
  end

  template target do
    owner     'root'
    group     node['root_group']
    mode      permissions
    cookbook  new_resource.cookbook
    source    new_resource.source
    variables default_variables.merge(new_resource.variables)
    action    :create
  end
end

action :delete do
  file "/etc/update-motd.d/#{new_resource.name}" do
    action :delete
  end
end
