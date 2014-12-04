require 'spec_helper'

describe 'motd::cow' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'adds a cow motd' do
    expect(chef_run).to create_motd('50-cow')
  end
end
