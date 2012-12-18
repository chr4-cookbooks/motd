#
# Cookbook Name:: motd
# Provider:: manage
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

action :create do
  # install colorize gem, so we can use colors in an easy way in our templates
  gem_package 'colorize' if new_resource.colorize

  # is this machine using update-motd?
  update_motd = ::File.directory? '/etc/update-motd.d'

  if update_motd
    target = "/etc/update-motd.d/#{new_resource.name}"
    permissions = '0755'
  else
    target = '/etc/motd'
    permissions = '0644'
  end

  template 'motd' do
    owner     'root'
    group     'root'
    path      target
    mode      permissions
    cookbook  new_resource.cookbook
    source    new_resource.source

    if new_resource.variables.empty?
      variables :update_motd => update_motd,
                :environment => node.chef_environment,
                :domain => node['domain'],
                :hostname => node['hostname']
    else
      variables new_resource.variables
    end
  end
end

action :delete do
  file "/etc/update-motd.d/#{new_resource.name}" do
    action :delete
  end
end
