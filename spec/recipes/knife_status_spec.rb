require 'spec_helper'

describe 'motd::knife_status' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  before do
    File.stub(:directory?).and_call_original
    File.stub(:directory?).with('/etc/update-motd.d').and_return(true)
  end

  it 'adds a knife status motd' do
    expect(chef_run).to create_motd('98-knife-status')
  end

  it 'creates last_successful_chef_run' do
    expect(chef_run).to create_file("#{Chef::Config[:file_cache_path]}/last_successful_chef_run")
  end
end
