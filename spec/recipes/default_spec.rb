require 'spec_helper'

describe 'motd::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  %w(cow knife_status).each do |recipe|
    it "includes the `#{recipe}` recipe" do
      expect(chef_run).to include_recipe "motd::#{recipe}"
    end
  end
end
