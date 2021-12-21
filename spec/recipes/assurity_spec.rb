require 'spec_helper'

describe 'motd::assurity' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'adds a assurity motd' do
    expect(chef_run).to create_motd('50-assurity')
  end
end
