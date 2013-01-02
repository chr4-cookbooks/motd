# Description

Installs message of the day (respects update-motd, if installed)

# Recipes

The default recipe installs a motd using the predefined cow template

# Providers

To use the provider in your cookbook, make sure you put the following line in your metadata.rb

    depends "motd"

## motd_manage

The name attribute is only used if update-motd is installed on the system.
If not, it has no meaning.

Create motd using the shipped cow template

    motd_manage '50-mymotd'

Create a motd using a custom template

    motd_manage '50-mymotd' do
      cookbook 'my cookbook'
      source   'test.erb'
    end

Remove a motd (if update-motd is used only)

    motd_manage '50-mymotd' do
      action :delete
    end
