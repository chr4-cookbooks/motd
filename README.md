# Description

Installs message of the day (respects update-motd, if installed)

# Definitions

To use the definition in your cookbook, make sure you put the following line in your metadata.rb

    depends "motd"

create motd using the shipped cow template

    motd '50-mymotd'

create a motd using a custom template

    motd '50-mymotd' do
      cookbook 'my cookbook'
      source   'test.erb'
      colorize false
    end

# Recipes

The default recipe installs a motd using the predefined cow template