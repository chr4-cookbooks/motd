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

  it "creates #{Chef::Config[:file_cache_path]}/handlers directory" do
    expect(chef_run).to create_directory("#{Chef::Config[:file_cache_path]}/handlers").with(
      mode: 00755,
    )
  end

  it 'adds a Chef handler' do
    expect(chef_run).to create_template("#{Chef::Config[:file_cache_path]}/handlers/knife_status.rb").with(
      mode: 00644,
      source: 'knife_status_handler.rb',
    )
  end

  it 'enables Motd::KnifeStatus as a Chef handler' do
    expect(chef_run).to enable_chef_handler('Motd::KnifeStatus')
  end
end
