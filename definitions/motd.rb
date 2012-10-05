#
# Cookbook Name:: motd
# Definition:: motd
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

define :motd, :cookbook => 'motd', :source => 'cow.erb', :colorize => true do
  # install colorize gem, so we can use colors in an easy way in our templates
  gem_package 'colorize' if params[:colorize]

  # is this machine using update-motd?
  update_motd = File.directory? '/etc/update-motd.d'

  if update_motd
    target = "/etc/update-motd.d/#{params[:name]}"
    permissions = '0755'
  else
    target = '/etc/motd'
    permissions = '0644'
  end

  template target do
    owner     'root'
    group     'root'
    mode      permissions
    cookbook  params[:cookbook]
    source    params[:source]
    variables :update_motd => update_motd
  end
end