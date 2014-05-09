require 'spec_helper'

describe 'MOTD' do
  if os[:family] == 'Ubuntu'
    describe file '/etc/update-motd.d/50-cow' do
      it { should be_file }
      it { should be_mode '755' }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      its(:content) do
        should match(/This is (\e\[0;34;49m)?default-ubuntu-(.*?)(\e\[0m)?, a vagrantup\.com _default server/)
      end
    end

    describe file '/etc/update-motd.d/98-knife-status' do
      it { should be_file }
      it { should be_mode '755' }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      its(:content) { should include 'Last chef run:' }
    end

    describe file '/tmp/kitchen/cache/handlers' do
      it { should be_directory }
      it { should be_mode '755' }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end

    describe file '/tmp/kitchen/cache/handlers/knife_status.rb' do
      it { should be_file }
      it { should be_mode '644' }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      its(:content) { should include 'KnifeStatus < Chef::Handler' }
    end
  else
    describe file '/etc/motd' do
      it { should be_file }
      it { should be_mode '644' }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      its(:content) do
        should match(/This is (\e\[0;34;49m)?default-centos-(.*?)(\e\[0m)?, a vagrantup\.com _default server/)
      end
    end
  end
end
