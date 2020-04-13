name             'motd'
version          '1.0.0'
description      'Installs/Configures motd'

chef_version     '>= 14.0'

maintainer       'Chris Aumann'
maintainer_email 'me@chr4.org'
source_url       'https://github.com/chr4-cookbooks/motd'
issues_url       'https://github.com/chr4-cookbooks/motd/issues'
license          'GPL-3.0'

%w(ubuntu debian redhat centos scientific amazon fedora).each do |os|
  supports os
end
